# Slice 747: JSON Internal Docs Port/Retire Evaluation

## Goal

Classify the old `json-merge` docs for `ConflictResolver`, `Emitter`,
`FreezeNode`, and `DebugLogger` as ported concepts, future fixture work, or
retired Ruby internals.

## Current Portable Surface

The active JSON packages expose portable behavior through fixtures and result
contracts:

- strict JSON and JSONC parsing,
- exact owner/path matching,
- recursive object merge,
- destination-wins scalar and array conflicts,
- destination trailing-comma fallback,
- policy reporting,
- structured diagnostics.

They do not expose the old Ruby internal classes as public cross-language
interfaces.

## Decisions

### Conflict Resolver

Port the behavior concepts that already have fixtures:

- destination-wins conflict behavior,
- template-only object member insertion,
- destination parse-error classification,
- fallback policy reporting,
- destination-wins array policy.

Do not port the old `Json::Merge::ConflictResolver` class API. Future
template-wins, removal-mode, and custom resolver behavior needs portable policy
fixtures before documentation or implementation.

### Emitter

Retire the old Ruby `Emitter` public docs for the current generated READMEs.
Current JSON output is canonical JSON. Formatting-preserving and
comment-preserving emitters remain future JSONC/comment-policy work.

### Freeze Comments

Do not claim JSON freeze-block support in current JSON README output.
Retain the old JSONC `// json-merge:freeze` idea as input to the cross-cutting
freeze-block infrastructure and JSONC package-shape tasks.

### Debug Logging

Retire old `JSON_MERGE_DEBUG=1` textual debug-output docs for generated
READMEs. Current docs should point at structured diagnostics, policy reports,
and future plan/report envelopes.

## Boundaries

- This slice does not remove old reference code.
- This slice does not implement template-wins, removal-mode, JSONC comment
  preservation, freeze blocks, or custom resolver APIs.
- JSONC comment preservation and freeze behavior remain open in the
  `jsonc-merge` tracker item unless separately fixtured.
