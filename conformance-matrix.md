# Conformance Matrix

This matrix defines the first cross-language alignment target for the merge
stack. It is intentionally smaller than the full Ruby surface area.

## MVP Scope

| Capability | Ruby | TypeScript | Rust | Go |
|---|---|---|---|---|
| Shared diagnostic/result contracts | Existing | Slice 02 | Slice 02 | Slice 02 |
| Tree-sitter runtime wrapper | Existing | Planned | Planned | Planned |
| Text analysis contract | Existing | Slice 03 | Slice 03 | Slice 03 |
| JSON and JSONC parse contract | Existing | Slice 04 | Slice 04 | Slice 04 |
| Text similarity contract | Existing | Slice 05 | Slice 05 | Slice 05 |
| Parser adapter contract | Existing | Slice 06 | Slice 06 | Slice 06 |
| JSON structural analysis contract | Existing | Slice 07 | Slice 07 | Slice 07 |
| JSON owner matching contract | Existing | Slice 08 | Slice 08 | Slice 08 |
| JSON merge-resolution contract | Existing | Slice 09 | Slice 09 | Slice 09 |
| Text merge-resolution contract | Existing | Slice 10 | Slice 10 | Slice 10 |
| Text block matching contract | Existing | Slice 11 | Slice 11 | Slice 11 |
| Text analysis and merge | Existing | MVP target | MVP target | MVP target |
| JSON merge | Existing | MVP target | MVP target | MVP target |
| JSONC comments | Existing | MVP target | MVP target | MVP target |
| Strict handling of trailing commas | Existing | MVP target | MVP target | MVP target |
| TOML merge | Existing | Later | Later | Later |
| YAML merge | Existing | Later | Later | Later |
| Markdown merge | Existing | Later | Later | Later |
| Ruleset execution | Existing | Later | Later | Later |
| Package templating layer | Existing | Later | Later | Later |

## Shared Expectations

All implementations should eventually share:

- fixture-driven conformance tests
- normalized diagnostic categories
- explicit freeze behavior
- explicit comment-handling behavior
- explicit parse failure and destination-parse-failure behavior

## Slice Roadmap

- Slice 01: foundation and monorepo shape
- Slice 02: diagnostic and result contracts
- Slice 03: text analysis contracts
- Slice 04: JSON and JSONC parse contracts
- Slice 05: text similarity contracts
- Slice 06: parser adapter contracts
- Slice 07: JSON structural analysis contracts
- Slice 08: JSON owner matching contracts
- Slice 09: JSON merge-resolution contracts
- Slice 10: text merge-resolution contracts
- Slice 11: text block matching contracts

## License Policy

All new non-Ruby implementation projects planned from this workspace should be
dual licensed under:

- `AGPL-3.0-only`
- `PolyForm-Small-Business-1.0.0`

See `LICENSE_TEMPLATE_PLAN.md` for the active workspace licensing plan context.
