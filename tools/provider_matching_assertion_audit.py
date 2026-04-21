#!/usr/bin/env python3
"""Report whether provider matching fixtures assert unmatched paths as well as matched pairs."""

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
    "ruby_provider": {
        "typescript": [],
        "go": [],
        "rust": [],
        "ruby": [Path("structuredmerge-ruby/gems/prism-merge/spec/fixtures_integration_spec.rb")],
    },
}

MATCHING_SLICE_PATTERNS = {
    "markdown_provider": [re.compile(r"slice-199-matching")],
    "toml_provider": [re.compile(r"slice-93-matching")],
    "yaml_provider": [re.compile(r"slice-98-matching")],
    "typescript_provider": [re.compile(r"slice-103-matching")],
    "ruby_provider": [re.compile(r"slice-219-matching")],
}

UNMATCHED_PATTERNS = {
    "typescript": [
        re.compile(r"unmatchedTemplate"),
        re.compile(r"unmatchedDestination"),
    ],
    "go": [
        re.compile(r"UnmatchedTemplate"),
        re.compile(r"UnmatchedDestination"),
    ],
    "rust": [
        re.compile(r"unmatched_template"),
        re.compile(r"unmatched_destination"),
    ],
    "ruby": [
        re.compile(r"unmatched_template"),
        re.compile(r"unmatched_destination"),
    ],
}


def workspace_root(script_path: Path) -> Path:
    return script_path.resolve().parents[2]


def file_text(path: Path) -> str:
    if not path.exists():
        raise FileNotFoundError(f"missing provider fixture file: {path}")
    return path.read_text()


def build_report(root: Path) -> dict[str, object]:
    providers: dict[str, dict[str, dict[str, bool]]] = {}
    gaps: dict[str, dict[str, str]] = {}

    for provider, host_paths in PROVIDERS.items():
        provider_report: dict[str, dict[str, bool]] = {}
        matching_patterns = MATCHING_SLICE_PATTERNS.get(provider, [])
        for host in HOSTS:
            texts = [file_text(root / rel_path) for rel_path in host_paths[host]]
            combined = "\n".join(texts)
            has_matching_fixture = any(pattern.search(combined) for pattern in matching_patterns)
            has_unmatched_assertions = all(
                pattern.search(combined) for pattern in UNMATCHED_PATTERNS.get(host, [])
            )
            provider_report[host] = {
                "has_matching_fixture": has_matching_fixture,
                "has_unmatched_assertions": bool(has_unmatched_assertions),
            }
            if has_matching_fixture and not has_unmatched_assertions:
                gaps.setdefault(provider, {})[host] = "matching fixture present without unmatched-path assertions"
        providers[provider] = provider_report

    return {
        "workspace_root": str(root),
        "providers": providers,
        "gaps": gaps,
    }


def print_table(report: dict[str, object]) -> int:
    gaps: dict[str, dict[str, str]] = report["gaps"]  # type: ignore[assignment]
    print("provider matching assertion audit")
    print(f"workspace: {report['workspace_root']}")
    print("")
    if not gaps:
        print("All configured provider matching fixtures assert unmatched paths across hosts.")
        return 0

    for provider, hosts in gaps.items():
        print(f"[{provider}]")
        for host, message in hosts.items():
            print(f"  {host}: {message}")
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
        return 0 if not report["gaps"] else 1

    return print_table(report)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
