#!/usr/bin/env python3
"""Report whether provider packages test unsupported backend override rejection."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path


HOSTS = ("typescript", "go", "rust", "ruby")

PROVIDERS = {
    "markdown_provider": {
        "typescript": [Path("typescript/packages/markdown-it-merge/test/contracts.test.ts")],
        "go": [Path("go/goldmarkmerge/fixtures_integration_test.go")],
        "rust": [Path("rust/crates/pulldown-cmark-merge/tests/fixtures.rs")],
        "ruby": [
            Path("ruby/gems/commonmarker-merge/spec/fixtures_integration_spec.rb"),
            Path("ruby/gems/kramdown-merge/spec/fixtures_integration_spec.rb"),
            Path("ruby/gems/markly-merge/spec/fixtures_integration_spec.rb"),
        ],
    },
    "toml_provider": {
        "typescript": [Path("typescript/packages/peggy-toml-merge/test/contracts.test.ts")],
        "go": [Path("go/pigeontomlmerge/fixtures_integration_test.go")],
        "rust": [Path("rust/crates/pest-toml-merge/tests/fixtures.rs")],
        "ruby": [
            Path("ruby/gems/citrus-toml-merge/spec/fixtures_integration_spec.rb"),
            Path("ruby/gems/parslet-toml-merge/spec/fixtures_integration_spec.rb"),
        ],
    },
    "yaml_provider": {
        "typescript": [Path("typescript/packages/js-yaml-merge/test/contracts.test.ts")],
        "go": [Path("go/goccygoyamlmerge/fixtures_integration_test.go")],
        "rust": [Path("rust/crates/yaml-serde-merge/tests/fixtures.rs")],
        "ruby": [Path("ruby/gems/psych-merge/spec/fixtures_integration_spec.rb")],
    },
    "typescript_provider": {
        "typescript": [Path("typescript/packages/typescript-compiler-merge/test/contracts.test.ts")],
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
        "ruby": [Path("ruby/gems/prism-merge/spec/fixtures_integration_spec.rb")],
    },
}

ALLOWED_HOSTS_BY_PROVIDER = {
    "typescript_provider": ["typescript"],
    "go_provider": ["go"],
    "ruby_provider": ["ruby"],
}

OVERRIDE_PATTERNS = {
    "typescript": [re.compile(r"rejects unsupported .*backend overrides"), re.compile(r"Unsupported .* backend")],
    "go": [re.compile(r"RejectsUnsupportedBackendOverrides"), re.compile(r"Unsupported .* backend")],
    "rust": [re.compile(r"rejects_unsupported_provider_backend_overrides"), re.compile(r"Unsupported .* backend")],
    "ruby": [re.compile(r"rejects unsupported provider backend overrides"), re.compile(r"Unsupported .* backend")],
}


def workspace_root(script_path: Path) -> Path:
    return script_path.resolve().parents[2]


def file_text(path: Path) -> str:
    if not path.exists():
        raise FileNotFoundError(f"missing provider test file: {path}")
    return path.read_text()


def build_report(root: Path) -> dict[str, object]:
    providers: dict[str, dict[str, bool]] = {}
    gaps: dict[str, list[str]] = {}

    for provider, host_paths in PROVIDERS.items():
        expected_hosts = ALLOWED_HOSTS_BY_PROVIDER.get(provider, list(HOSTS))
        provider_result: dict[str, bool] = {}
        for host in HOSTS:
            texts = [file_text(root / rel_path) for rel_path in host_paths[host]]
            combined = "\n".join(texts)
            has_assertion = all(pattern.search(combined) for pattern in OVERRIDE_PATTERNS[host]) if texts else False
            provider_result[host] = has_assertion
            if host in expected_hosts and not has_assertion:
                gaps.setdefault(provider, []).append(host)
        providers[provider] = provider_result

    return {
        "workspace_root": str(root),
        "providers": providers,
        "gaps": gaps,
    }


def print_table(report: dict[str, object]) -> int:
    gaps: dict[str, list[str]] = report["gaps"]  # type: ignore[assignment]
    print("provider backend override audit")
    print(f"workspace: {report['workspace_root']}")
    print("")
    if not gaps:
        print("All configured provider packages test unsupported backend override rejection.")
        return 0

    for provider, hosts in gaps.items():
        print(f"[{provider}]")
        print(f"  missing_in={', '.join(hosts)}")
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
