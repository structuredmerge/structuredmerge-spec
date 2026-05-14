# Slice 744: JSON README Example Mapping

## Goal

Map the old `json-merge` README examples to current structured-merge fixtures
before porting more prose or implementation details.

The old README mixes JSON behavior contracts, Ruby-only API snippets, shared
README boilerplate, and obsolete secure-installation prose. This slice keeps
the JSON-specific value visible while separating already-fixtured behavior from
missing or undecided behavior.

## Shared Behavior

JSON README example migration SHOULD record each example with:

- a stable example id,
- the old README section where it appeared,
- the portable behavior being documented,
- existing fixture coverage when present,
- missing fixture coverage when absent,
- a migration decision.

Current generated READMEs MUST NOT claim behavior from old examples unless it
is backed by an active fixture, a current implementation test, or an explicit
README-prose-only decision.

## Acceptance Data

The fixture for this slice maps old `json-merge` README examples for:

1. strict JSON parsing,
2. JSONC comment handling,
3. supported owner and matching shapes,
4. basic object merge behavior,
5. template-only insertion,
6. destination-wins array policy,
7. advanced nested object leaf merge,
8. tree-sitter strict JSON adapter behavior,
9. fuzzy property matching,
10. array element fuzzy matching,
11. conflict resolver, emitter, freeze comments, and debug logging docs,
12. retired secure-installation prose.

## Boundaries

- This slice is a mapping step. It does not implement fuzzy matching or
  formatter/emitter behavior by itself.
- `jsonc-merge` package-shape decisions remain in the separate `jsonc-merge`
  tracker item.
- Old RubyGems secure-installation prose remains discarded.
