# Slice 1041: Template Token Application Contract

Part of slice-1040 (ast-template extraction). This slice defines the first
extracted contract surface: **token application** — how a templating engine
substitutes tokens in template content and polices tokens that survive
substitution.

Status: **implemented** (2026-10-17). ast-template `TokenApplication`:
structuredmerge/structuredmerge-ruby `c391d1243`; kettle-jem delegation:
`d87990772` (suite verified green against the local engine — 742 examples,
the only failures being the pre-existing nomono floor-sync debt fixed
separately in `a9c7f03b7`). Conformance fixtures: structuredmerge/fixtures
`c1f9b29`. The kettle-jem floor (`ast-template >= 7.1.11`) is unresolvable
until the family wave bumps and publishes 7.1.11 — the documented mid-cycle
sequencing state; local kettle-jem bundles unblock at `mise run bump patch`.

## Scope

Token *mechanics* — parsing, grammar, segment rules — belong to
`token-resolver` and are out of scope here. This contract covers the
*application policy* layer that sits above `Token::Resolver` and below a
consumer profile:

1. Replacements are normalized (keys and values stringified) before
   resolution.
2. Resolution is non-destructive: a token with no replacement is kept
   verbatim in the output (`on_missing: :keep`).
3. When `scan_unresolved` is on, the *resolved output* is re-scanned for
   tokens whose **first segment** equals the consumer's namespace. Any such
   token is an error: the consumer promised to fill its namespace and failed.
4. Tokens outside the consumer's namespace are tolerated (another consumer or
   a later pass may own them).

The error carries the sorted, deduplicated list of full token keys (segments
joined by their original separators). Ruby raises
`Ast::Template::UnresolvedTokensError < ArgumentError` with a `tokens`
attribute so consumers can re-raise with their own branded message.

## Config mapping

The token config maps 1:1 onto the existing transport schema
`TemplateTokenConfig` (`pre`, `post`, `separators`, `min_segments`,
`max_segments`, `segment_pattern`) and onto `Token::Resolver::Config` in the
Ruby host. Consumers own their config instance (kettle-jem's
`TEMPLATE_TOKEN_CONFIG` uses separators `["|", ":"]`).

## Canonical keys and namespace matching

Hosts canonicalize token keys: segments are joined with the **first**
configured separator, regardless of the separator written in the template.
With separators `["|", ":"]`, the template text `{KJ:NAME}` parses to the
canonical key `KJ|NAME`. Two consequences the fixtures pin down:

1. **Replacements are keyed by canonical form.** `{"KJ|NAME" => "demo"}`
   resolves both `{KJ|NAME}` and `{KJ:NAME}`. A replacement keyed by a
   non-canonical form (`{"KJ:NAME" => ...}`) matches nothing.
2. **Kept-missing output is canonicalized.** An unresolved `{KJ:UNSET}`
   re-emerges as `{KJ|UNSET}` in the output. The unresolved scan therefore
   sees canonical keys, and namespace matching is simply *canonical first
   segment equals namespace*. This is why kettle-jem's legacy pipe-only
   `grep(/\AKJ\|/)` scan was already correct — there is no colon-form escape
   hatch to close. Error reports list canonical keys.

## Fixture anchor

`structuredmerge/fixtures/templating/slice-1041-token-application/manifest.json`
holds the conformance cases every host must satisfy:

| case | meaning |
|---|---|
| `basic_substitution` | pipe-form token replaced |
| `colon_separator_substitution` | colon-form token resolves from the canonically-keyed replacement |
| `colon_missing_normalizes_on_keep` | kept-missing output emits the canonical token form |
| `non_string_values_stringified` | integer replacement renders as text |
| `missing_token_kept_when_scan_disabled` | `scan_unresolved: false` keeps unresolved namespace tokens |
| `unresolved_namespace_token_errors` | pipe-form unresolved namespaced token raises, listing `{KJ|UNSET}` |
| `unresolved_colon_form_errors` | colon-form unresolved namespaced token raises, reported canonically |
| `multiple_unresolved_sorted_deduped` | error lists `{KJ|A}, {KJ|B}` once each, sorted |
| `foreign_namespace_tolerated` | unresolved `{OTHER|THING}` passes through |
| `single_segment_braces_not_tokens` | `{KJ}` is literal text (min_segments: 2), no error |
| `text_without_tokens` | plain text round-trips |

Each case carries its own `config`/`namespace`/`scan_unresolved` overrides so
hosts do not inherit hidden defaults. `expected` is either `{output}` or
`{error: {tokens: [...]}}` (full keys; message formatting is host-defined).

## Ruby implementation

`Ast::Template::TokenApplication` (new, in ast-template):

- `apply_tokens(content, replacements, config:, namespace:, scan_unresolved: true)` → String
- `unresolved_namespaced_tokens(content, config:, namespace:)` → sorted Array of full keys
- `stringify_replacements(replacements)` → Hash with string keys and values

`kettle-jem`'s `resolve_template_tokens` delegates to `apply_tokens` and
re-raises with its legacy message (`unresolved kettle-jem template tokens: ...`)
so existing callers and specs see no change. Its YAML-value scan
(`yaml_scalar_value_template_tokens`) delegates to
`unresolved_namespaced_tokens`, inheriting the same tightening.

ast-template gains a runtime dependency on `token-resolver` (`~> 2.0`,
`>= 2.0.10`; the same floor kettle-jem already proves).

## Consumer sequencing

kettle-jem's delegation requires ast-template ≥ 7.1.11 (first version shipping
the contract implementation). The structuredmerge family bumps in lockstep at
the next wave (`mise run bump patch`), so the kettle-jem rewiring lands with
or after that bump — floor `>= 7.1.11` — and the wave publishes ast-template
before kettle-jem in dependency order. Until the bump, ast-template's own
suite verifies the contract against the fixtures.
