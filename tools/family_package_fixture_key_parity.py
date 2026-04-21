#!/usr/bin/env python3
"""Report fixture-slice parity for family packages across host repos."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


HOSTS = ("typescript", "go", "rust", "ruby")

FAMILIES = {
    "tree_haver": {
        "typescript": Path("typescript/packages/tree-haver/test/fixtures.integration.test.ts"),
        "go": Path("go/treehaver/fixtures_integration_test.go"),
        "rust": Path("rust/crates/tree-haver/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/tree_haver/spec/fixtures_integration_spec.rb"),
    },
    "text": {
        "typescript": Path("typescript/packages/text-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/textmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/text-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/text-merge/spec/fixtures_integration_spec.rb"),
    },
    "json": {
        "typescript": Path("typescript/packages/json-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/jsonmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/json-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/json-merge/spec/fixtures_integration_spec.rb"),
    },
    "markdown": {
        "typescript": Path("typescript/packages/markdown-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/markdownmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/markdown-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/markdown-merge/spec/fixtures_integration_spec.rb"),
    },
    "toml": {
        "typescript": Path("typescript/packages/toml-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/tomlmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/toml-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/toml-merge/spec/fixtures_integration_spec.rb"),
    },
    "yaml": {
        "typescript": Path("typescript/packages/yaml-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/yamlmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/yaml-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/yaml-merge/spec/fixtures_integration_spec.rb"),
    },
    "go_source": {
        "typescript": Path("typescript/packages/go-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/gomerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/go-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/go-merge/spec/fixtures_integration_spec.rb"),
    },
    "rust_source": {
        "typescript": Path("typescript/packages/rust-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/rustmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/rust-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/rust-merge/spec/fixtures_integration_spec.rb"),
    },
    "typescript_source": {
        "typescript": Path("typescript/packages/typescript-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/typescriptmerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/typescript-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/typescript-merge/spec/fixtures_integration_spec.rb"),
    },
    "ruby_source": {
        "typescript": Path("typescript/packages/ruby-merge/test/fixtures.integration.test.ts"),
        "go": Path("go/rubymerge/fixtures_integration_test.go"),
        "rust": Path("rust/crates/ruby-merge/tests/fixtures.rs"),
        "ruby": Path("structuredmerge-ruby/gems/ruby-merge/spec/fixtures_integration_spec.rb"),
    },
}

SLICE_PATTERN = re.compile(r"(slice-\d+-[a-z0-9-]+)")


def workspace_root(script_path: Path) -> Path:
    return script_path.resolve().parents[2]


def fixture_keys(source_path: Path) -> set[str]:
    if not source_path.exists():
        raise FileNotFoundError(f"missing package fixture file: {source_path}")
    text = source_path.read_text()
    return {
        match.group(1).split("/", 1)[0]
        for match in SLICE_PATTERN.finditer(text)
    }


def key_from_slice(slice_dir: str) -> str:
    _, _, suffix = slice_dir.partition("-")
    _, _, name = suffix.partition("-")
    return name.replace("-", "_")


def build_report(root: Path) -> dict[str, object]:
    families: dict[str, dict[str, list[str]]] = {}
    parity_gaps: dict[str, dict[str, list[str]]] = {}

    for family, host_paths in FAMILIES.items():
        family_hosts: dict[str, list[str]] = {}
        key_presence: dict[str, list[str]] = {}
        for host in HOSTS:
            keys = sorted(key_from_slice(slice_dir) for slice_dir in fixture_keys(root / host_paths[host]))
            family_hosts[host] = keys
            for key in keys:
                key_presence.setdefault(key, []).append(host)
        families[family] = family_hosts
        gaps = {
            key: present_hosts
            for key, present_hosts in sorted(key_presence.items())
            if len(present_hosts) != len(HOSTS)
        }
        if gaps:
            parity_gaps[family] = gaps

    return {
        "workspace_root": str(root),
        "families": families,
        "parity_gaps": parity_gaps,
    }


def print_table(report: dict[str, object]) -> int:
    parity_gaps: dict[str, dict[str, list[str]]] = report["parity_gaps"]  # type: ignore[assignment]
    print("family package fixture-key parity")
    print(f"workspace: {report['workspace_root']}")
    print("")
    if not parity_gaps:
        print("All configured family packages cover the same fixture keys across hosts.")
        return 0

    for family, gaps in parity_gaps.items():
        print(f"[{family}]")
        width = max(len(key) for key in gaps)
        for key, present_hosts in gaps.items():
            missing = [host for host in HOSTS if host not in present_hosts]
            print(f"  {key.ljust(width)}  missing_in={', '.join(missing)}")
        print("")
    return 1


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--workspace-root", type=Path)
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args(argv)

    root = args.workspace_root.resolve() if args.workspace_root else workspace_root(Path(__file__))
    report = build_report(root)

    if args.json:
        json.dump(report, sys.stdout, indent=2, sort_keys=True)
        sys.stdout.write("\n")
        return 0 if not report["parity_gaps"] else 1

    return print_table(report)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
