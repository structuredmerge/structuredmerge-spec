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
| Text match-driven merge contract | Existing | Slice 12 | Slice 12 | Slice 12 |
| Text content-refined matching contract | Existing | Slice 13 | Slice 13 | Slice 13 |
| Text analysis and merge | Existing | MVP target | MVP target | MVP target |
| JSON merge | Existing | MVP target | MVP target | MVP target |
| JSONC comments | Existing | MVP target | MVP target | MVP target |
| Strict handling of trailing commas | Existing | MVP target | MVP target | MVP target |
| TOML merge | Existing | Slice 90-94 | Slice 90-94 | Slice 90-94 |
| TOML backend plurality | Existing | Slice 134 | Slice 134 | Slice 134 |
| TOML backend plan contexts | Existing | Slice 135-137 | Slice 135-137 | Slice 135-137 |
| YAML backend plurality | Slice 170 | Slice 170 | Slice 170 | Slice 170 |
| YAML backend plan contexts | Slice 171-174 | Slice 171-174 | Slice 171-174 | Slice 171-174 |
| YAML polyglot backend path | Slice 183-186 | Slice 183-186 | Slice 183-186 | Slice 183-186 |
| Canonical stable suites with alternate config backends | Existing | Slice 175-177 | Slice 175-177 | Slice 175-177 |
| Canonical widened suites with alternate config backends | Existing | Slice 178-182 | Slice 178-182 | Slice 178-182 |
| TOML named-suite planning and reporting | Existing | Slice 138-140 | Slice 138-140 | Slice 138-140 |
| TOML canonical-manifest paths | Existing | Slice 141 | Slice 141 | Slice 141 |
| YAML merge | Existing | Slice 95-99 | Slice 95-99 | Slice 95-99 |
| TypeScript family merge | Existing | Slice 100-104 | Slice 100-104 | Slice 100-104 |
| Rust family merge | Existing | Slice 105-108 | Slice 105-108 | Slice 105-108 |
| Go family merge | Existing | Slice 109-112 | Slice 109-112 | Slice 109-112 |
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
- the same backend-ownership rule:
  reusable parser frameworks in `tree-haver`, one-trick parsers in family
  libraries
- the same family-level backend-plurality rule:
  supported backends for one family SHOULD satisfy the same family-facing
  fixtures unless a backend restriction is declared explicitly

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
- Slice 12: text match-driven merge contracts
- Slice 13: text content-refined matching contracts
- Slice 90-94: TOML family contracts
- Slice 95-99: YAML family contracts
- Slice 100-112: source-language family contracts
- Slice 132: backend ownership boundary
- Slice 133: family substrate layer
- Slice 134: TOML family backend plurality
- Slice 135-137: TOML backend feature profiles, plan contexts, and family manifest
- Slice 138-140: TOML suite definitions, named-suite plans, and manifest report
- Slice 141: TOML family in the canonical manifest
- Slice 142-143: YAML family plan contexts and family manifest
- Slice 144-146: YAML suite definitions, named-suite plans, and manifest report
- Slice 147: YAML family in the canonical manifest
- Slice 148: aggregate config-family manifest
- Slice 149: aggregate config-family suite plans
- Slice 150: aggregate config-family manifest report
- Slice 151: aggregate config-family review state
- Slice 152: aggregate config-family reviewed default
- Slice 153: aggregate config-family replay application
- Slice 154: stable config suites in the canonical manifest
- Slice 155: canonical stable-suite plans
- Slice 156: canonical stable-suite report
- Slice 157: canonical stable-suite review state
- Slice 158: source-family review state
- Slice 159: source-family reviewed default
- Slice 160: source-family replay application
- Slice 161: source suites in canonical manifest
- Slice 162: canonical widened-suite plans
- Slice 163: canonical widened-suite report
- Slice 164: canonical widened-suite review state
- Slice 165: canonical widened-suite reviewed default
- Slice 166: canonical widened-suite replay application
- Slice 167: backend-sensitive aggregate suite plans
- Slice 168: backend-sensitive aggregate tree-sitter report
- Slice 169: backend-sensitive aggregate native report
- Slice 170: YAML family backend plurality
- Slice 171: YAML family backend feature profiles
- Slice 172: YAML family backend plan contexts
- Slice 173: YAML family backend named suite plans
- Slice 174: YAML family backend manifest report
- Slice 175: canonical stable-suite backend plans
- Slice 176: canonical stable-suite backend report
- Slice 177: canonical stable-suite backend review state
- Slice 178: canonical widened-suite backend plans
- Slice 179: canonical widened-suite backend report
- Slice 180: canonical widened-suite backend review state
- Slice 181: canonical widened-suite backend reviewed default
- Slice 182: canonical widened-suite backend replay application
- Slice 183: YAML polyglot backend feature profiles
- Slice 184: YAML polyglot backend plan contexts
- Slice 185: YAML polyglot backend named-suite plans
- Slice 186: YAML polyglot backend manifest report

## License Policy

All new non-Ruby implementation projects planned from this workspace should be
dual licensed under:

- `AGPL-3.0-only`
- `PolyForm-Small-Business-1.0.0`

See `LICENSE_TEMPLATE_PLAN.md` for the active workspace licensing plan context.
