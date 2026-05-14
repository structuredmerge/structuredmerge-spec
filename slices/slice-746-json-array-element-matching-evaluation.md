# Slice 746: JSON Array Element Matching Evaluation

## Goal

Evaluate the old `json-merge` array element matching examples against current
JSON conformance behavior.

The old README and `ObjectMatchRefiner` docs suggested that array elements with
matching identifiers or similar structure could be paired. Current
structured-merge JSON behavior intentionally preserves destination arrays as
whole values.

## Current Contract

Slice 16 defines the active baseline array policy:

1. when both template and destination values are arrays, the destination array
   is preserved as a whole,
2. template array elements are not appended, interleaved, or element-matched,
3. the policy applies recursively inside object merges,
4. results report the `destination_wins_array` policy.

## Old Value

The old array element examples still contain useful future design input:

- arrays of objects can expose element owners,
- object elements may have natural identifiers such as `id`,
- object elements may also be similar by key structure,
- comment preservation for JSONC arrays matters if element-level merge returns,
- removed destination-only elements and template-only elements need explicit
  policy decisions.

## Decision

Do not port old array element matching into current behavior or generated
READMEs.

Keep destination-wins arrays as the current portable contract. Treat old
element matching as a future alternative array policy that must be fixture-first
and opt-in. Any future policy must specify:

- identity strategy, such as exact `id` match or configured key path,
- behavior for destination-only elements,
- behavior for template-only elements,
- ordering rules for accepted insertions,
- conflict handling inside matched object elements,
- JSONC comment movement or preservation rules,
- diagnostics that explain why each element matched, inserted, or remained
  destination-owned.

## Boundaries

- This slice does not change slice 16.
- This slice does not implement array element merge in any language.
- Fuzzy object-member matching remains separate from array policy selection.
