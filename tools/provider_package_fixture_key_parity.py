#!/usr/bin/env python3
"""Report fixture-slice parity for provider packages across host repos."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


HOSTS = ("typescript", "go", "rust", "ruby")

PROVIDERS = {
    "markdown_provider": {
        "typescript": [Path("typescript/packages/markdown-it-merge/test/fixtures.integration.test.ts")],
        "go": [Path("go/goldmarkmerge/fixtures_integration_test.go")],
        "rust": [Path("rust/crates/pulldown-cmark-merge/tests/fixtures.rs")],
        "ruby": [
            Path("structuredmerge-ruby/gems/commonmarker-merge/spec/fixtures_integration_spec.rb"),
            Path("structuredmerge-ruby/gems/kramdown-merge/spec/fixtures_integration_spec.rb"),
            Path("structuredmerge-ruby/gems/markly-merge/spec/fixtures_integration_spec.rb"),
        ],
    },
    "toml_provider": {
        "typescript": [Path("typescript/packages/peggy-toml-merge/test/fixtures.integration.test.ts")],
        "go": [Path("go/pigeontomlmerge/fixtures_integration_test.go")],
        "rust": [Path("rust/crates/pest-toml-merge/tests/fixtures.rs")],
        "ruby": [
            Path("structuredmerge-ruby/gems/citrus-toml-merge/spec/fixtures_integration_spec.rb"),
            Path("structuredmerge-ruby/gems/parslet-toml-merge/spec/fixtures_integration_spec.rb"),
        ],
    },
    "yaml_provider": {
        "typescript": [Path("typescript/packages/js-yaml-merge/test/fixtures.integration.test.ts")],
        "go": [Path("go/goccygoyamlmerge/fixtures_integration_test.go")],
        "rust": [Path("rust/crates/yaml-serde-merge/tests/fixtures.rs")],
        "ruby": [Path("structuredmerge-ruby/gems/psych-merge/spec/fixtures_integration_spec.rb")],
    },
    "typescript_provider": {
        "typescript": [Path("typescript/packages/typescript-compiler-merge/test/fixtures.integration.test.ts")],
        "go": [],
        "rust": [],
        "ruby": [],
    },
    "go_provider": {
        "typescript": [],
        "go": [Path("go/goparsermerge/fixtures_integration_test.go")],
        "rust": [],
        "ruby": [],
    },
    "ruby_provider": {
        "typescript": [],
        "go": [],
        "rust": [],
        "ruby": [Path("structuredmerge-ruby/gems/prism-merge/spec/fixtures_integration_spec.rb")],
    },
}

ALLOWED_HOSTS_BY_PROVIDER = {
    "typescript_provider": ["typescript"],
    "go_provider": ["go"],
    "ruby_provider": ["ruby"],
}

SLICE_PATTERN = re.compile(r"(slice-\d+-[a-z0-9-]+)")


def workspace_root(script_path: Path) -> Path:
    return script_path.resolve().parents[2]


def key_from_slice(slice_dir: str) -> str:
    _, _, suffix = slice_dir.partition("-")
    _, _, name = suffix.partition("-")
    return name.replace("-", "_")


def fixture_keys_for_file(source_path: Path) -> set[str]:
    if not source_path.exists():
        raise FileNotFoundError(f"missing provider fixture file: {source_path}")
    text = source_path.read_text()
    return {
        key_from_slice(match.group(1))
        for match in SLICE_PATTERN.finditer(text)
    }


def build_report(root: Path) -> dict[str, object]:
    providers: dict[str, dict[str, list[str]]] = {}
    parity_gaps: dict[str, dict[str, list[str]]] = {}

    for provider, host_paths in PROVIDERS.items():
        provider_hosts: dict[str, list[str]] = {}
        key_presence: dict[str, set[str]] = {}
        for host in HOSTS:
            keys: set[str] = set()
            for rel_path in host_paths[host]:
                keys.update(fixture_keys_for_file(root / rel_path))
            provider_hosts[host] = sorted(keys)
            for key in keys:
                key_presence.setdefault(key, set()).add(host)
        providers[provider] = provider_hosts
        expected_hosts = sorted(ALLOWED_HOSTS_BY_PROVIDER.get(provider, list(HOSTS)))
        gaps = {
            key: sorted(present_hosts)
            for key, present_hosts in sorted(key_presence.items())
            if sorted(present_hosts) != expected_hosts
        }
        if gaps:
            parity_gaps[provider] = gaps

    return {
        "workspace_root": str(root),
        "providers": providers,
        "parity_gaps": parity_gaps,
    }


def print_table(report: dict[str, object]) -> int:
    parity_gaps: dict[str, dict[str, list[str]]] = report["parity_gaps"]  # type: ignore[assignment]
    print("provider package fixture-key parity")
    print(f"workspace: {report['workspace_root']}")
    print("")
    if not parity_gaps:
        print("All configured provider packages cover the same fixture keys across hosts.")
        return 0

    for provider, gaps in parity_gaps.items():
        print(f"[{provider}]")
        width = max(len(key) for key in gaps)
        expected_hosts = ALLOWED_HOSTS_BY_PROVIDER.get(provider, list(HOSTS))
        for key, present_hosts in gaps.items():
            missing = [host for host in expected_hosts if host not in present_hosts]
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
