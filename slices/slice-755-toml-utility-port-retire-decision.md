# Slice 755: TOML Utility Port/Retire Decision

## Goal

Decide whether the old TOML `KeySorter` and `TableMatchRefiner` utilities
should be ported now, retired, or deferred behind fixture contracts.

## KeySorter

Old value:

- sorts key/value pairs alphabetically within gap-separated blocks;
- keeps leading comments attached to the following key;
- treats blank lines as block separators;
- treats table and array-of-table headers as structural boundaries;
- leaves trailing comments with no following key as non-sortable content.

Decision: defer, do not port now.

This is useful output policy, but it is not the current cross-language TOML
contract. It should be ported only after a TOML key-ordering fixture defines
inputs, expected output, comment attachment, structural boundaries, and
convergence.

## TableMatchRefiner

Old value:

- matches TOML tables by table-name similarity;
- incorporates key overlap and document position;
- supports configurable weights;
- accepts matches above a threshold;
- produces scored match results.

Decision: defer, do not port now.

This is useful matching policy, but the current TOML contract is path/equality
owner matching. It should be ported only after a TOML fuzzy-table-matching
fixture defines scoring inputs, expected matches, threshold behavior, and
cross-language determinism.

## Retired Pieces

Do not port old Ruby class names, private helper APIs, or implementation
coupling as public README value. If the behavior is retained, the portable
contract is the fixture shape, not the Ruby class surface.

## Recommendation

Create future TOML fixture slices in this order:

1. Fuzzy table matching.
2. Key ordering with comment attachment.
3. Comment-preserving table and array-of-tables merge output.
4. Emitter conformance.

Until then, generated TOML READMEs should avoid claiming these utilities.
