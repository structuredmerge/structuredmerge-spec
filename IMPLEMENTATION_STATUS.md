# Implementation Status

Launch-readiness snapshot for the StructuredMerge implementation set.

StructuredMerge launches with four peer language implementations:

- [Go](https://github.com/structuredmerge/structuredmerge-go)
- [TypeScript](https://github.com/structuredmerge/structuredmerge-typescript)
- [Rust](https://github.com/structuredmerge/structuredmerge-rust)
- [Ruby](https://github.com/structuredmerge/structuredmerge-ruby)

The implementations are interchangeable consumers of the same public spec and shared fixture corpus. This file tracks alignment at the contract level, not feature ownership by any one runtime.

## Current launch contract

The public launch story should stay tied to these shared artifacts:

- `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md` for ruleset vocabulary.
- `merge-lexicon.md` for portable terminology.
- `conformance-matrix.md` for capability planning.
- `structuredmerge-fixtures` for runnable shared cases.
- normalized diagnostics and result shapes.
- review/replay vocabulary for unresolved outcomes.

## Implementation matrix

| Implementation | Repo | Runtime surface | Launch role |
| --- | --- | --- | --- |
| Go | `structuredmerge-go` | Go module workspace | Native Go packages for StructuredMerge tooling. |
| TypeScript | `structuredmerge-typescript` | pnpm workspace | JavaScript/TypeScript packages for editor, web, and Node-hosted tools. |
| Rust | `structuredmerge-rust` | Cargo workspace | Rust crates for native tools and embeddable merge components. |
| Ruby | `structuredmerge-ruby` | Ruby monorepo | Ruby gems aligned to the shared contract and fixture corpus. |

## Alignment targets

| Area | Launch expectation |
| --- | --- |
| Diagnostics and results | Shared category names and compatible report shapes. |
| Text, JSON, and JSONC | Early conformance target for parsing, matching, and merge-resolution behavior. |
| TOML and YAML | Config-family suites with explicit capability reporting where support differs. |
| Source-language families | Go, TypeScript, Rust, and Ruby fixture families for code-aware merge cases. |
| Review and replay | Unresolved cases should be reportable in a form that can be reviewed and replayed. |

## What counts as portable

A behavior should not be treated as portable until it is:

1. named in the shared vocabulary,
2. represented by fixture data or a planned conformance slice,
3. expressible through normalized diagnostics/result shapes, and
4. implemented or explicitly marked unsupported by each launch implementation.

## Public wording rules

Use:

- “Four implementations, one contract.”
- “Peer implementations.”
- “Shared spec and fixture corpus.”
- “Conformance is the product boundary.”

Avoid:

- calling one implementation canonical,
- implying separate product lines by language,
- claiming full conformance before fixture-backed evidence exists,
- discussing old package lineage in public positioning.

## Next useful updates

- Add generated status tables once parity tooling produces stable output for all four repos.
- Link each conformance slice to the fixture families that exercise it.
- Record unsupported capabilities explicitly instead of leaving gaps ambiguous.
- Keep this file synchronized with `conformance-matrix.md` before launch announcements.
