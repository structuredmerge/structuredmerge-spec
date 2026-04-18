# Conformance Matrix

This matrix defines the first cross-language alignment target for the merge
stack. It is intentionally smaller than the full Ruby surface area.

## MVP Scope

| Capability | Ruby | TypeScript | Rust | Go |
|---|---|---|---|---|
| Tree-sitter runtime wrapper | Existing | Planned | Planned | Planned |
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

## License Policy

All new non-Ruby implementation projects planned from this workspace should be
dual licensed under:

- `AGPL-3.0-only`
- `PolyForm-Small-Business-1.0.0`

See `LICENSE_TEMPLATE_PLAN.md` for the active workspace licensing plan context.

