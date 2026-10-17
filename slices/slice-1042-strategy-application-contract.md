# Slice 1042: Template Strategy Application Contract

Part of slice-1040 (ast-template extraction). This slice defines the second
extracted contract surface: **strategy resolution and application** — how an
engine decides what happens to one destination file, given a strategy.

Status: **implemented** (2026-10-17). ast-template `Strategies`:
structuredmerge/structuredmerge-ruby `e94718825`; kettle-jem delegation of the
decision predicates: `127aa6f1d` (full suite green, 742 examples). Conformance
fixtures: structuredmerge/fixtures `ad6ca6f`. One contract decision landed
during implementation: `write_action` tracks FILE existence (empty-but-existing
destination is `update`, not `create`) — fixture and table updated
accordingly. Committed lockfile repair after boot-time platform stripping:
`a448afbf2` (see the kettle-family-release-chain skill note on the boot
re-resolution signature).

## Strategy vocabulary

Four strategies, aligned with the `TemplateStrategyOverride` transport schema
and the slice-353 session fixtures:

- `merge` (default) — merge template into destination via the format merger.
- `keep_destination` — destination wins entirely; nothing is written. An
  absent destination is NOT created (keep is not create-from-template).
- `raw_copy` — template content is written verbatim (no token resolution, no
  merge).
- `accept_template` — resolved template content replaces destination
  wholesale (token resolution applies; no merge).

## Resolution

`resolve(default:, overrides:, path:)` returns the effective strategy for a
destination path: the override whose `path` matches, else the default.
Overrides are `TemplateStrategyOverride` entries (`{path, strategy}`).

## Application decision

`plan_entry(strategy:, template_content:, destination_content:)` returns the
plan vocabulary used by the slice-353 transport fixtures
(`execution_action` / `write_action` / `status`, present tense for plans,
past tense for apply reports):

| strategy | destination | execution_action | write_action | content |
|---|---|---|---|---|
| keep_destination | present | keep | keep | none (destination untouched) |
| keep_destination | absent | keep | keep | none (no creation) |
| raw_copy | any | raw_copy | create/update | template verbatim |
| accept_template | any | merge_prepared_content | create/update | resolved template |
| merge | absent | merge_prepared_content | create | template (nothing to merge) |
| merge | empty (existing file) | merge_prepared_content | update | template (nothing to merge) |
| merge | identical to template | keep | keep | none |
| merge | differs | merge_prepared_content | update | deferred to merger (slice-1043) |

Notes:

- `merge` with an empty or absent destination never invokes the merger — the
  template becomes the content. `merge` with an identical destination never
  invokes the merger — the destination is kept. These short-circuits exist in
  kettle-jem today (`merge_config_template_source`) and are load-bearing:
  mergers are the expensive, fallible step.
- The `differs` row is where this contract ends and merge dispatch
  (slice-1043) begins: the engine reports the action; the consumer's merger
  produces the content.
- `write_action` tracks FILE existence: `create` only when the destination is
  absent (nil); an existing-but-empty destination is an `update`.
- `raw_copy` bypasses token resolution (kettle-jem behavior: the raw path
  returns finalized template content without `resolve_template_tokens`).
  Consumer-side finalization (e.g. kettle-jem's workflow finalizers) is a
  consumer hook and out of this contract's scope.

## Fixture anchor

`structuredmerge/fixtures/templating/slice-1042-strategy-application/manifest.json`:
resolution cases (default, matching override, non-matching override) and one
application case per table row above, each with explicit
`strategy`/`template_content`/`destination_content` and the expected
`execution_action`/`write_action`/`status`/`content` (or its absence).

## Ruby implementation

`Ast::Template::Strategies` (new, in ast-template):

- `STRATEGIES` — the four-strategy vocabulary.
- `resolve(default: "merge", overrides: [], path:)` → String strategy.
- `plan_entry(strategy:, template_content:, destination_content:)` → Hash with
  `execution_action`, `write_action`, `status`, and `content` (nil when the
  merger or the destination owns the outcome).
- `keep_destination?(strategy)` and `trivial_merge_outcome(template_content,
  destination_content)` (→ `:empty_destination` | `:identical` | nil) — the
  predicate pair kettle-jem's `apply_template_source` /
  `merge_config_template_source` delegate to, so the decision rules live in
  one place while kettle-jem's gem-specific postprocessor wrappers stay put.

The full strategy *switch* (the merger invocation and postprocessor hooks)
arrives with slice-1043 (plan/apply + merge dispatch); this slice extracts
the decision rules only.
