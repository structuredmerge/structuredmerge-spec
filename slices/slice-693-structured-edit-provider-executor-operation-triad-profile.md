# Slice 693: Structured Edit Provider Executor Operation Triad Profile

## Goal

Standardize how a provider executor advertises support for the canonical
structured-edit operation triad.

## Shared Behavior

This slice defines one shared provider-executor capability surface:

1. an executor profile may advertise ordered operation profiles for `insert`,
   `replace`, and `delete`,
2. the operation profiles use the canonical shared operation kinds from slice
   692,
3. `insert` is represented as explicit payload insertion at an optional
   destination,
4. `replace` is represented as selected-source rewrite with explicit payload,
5. `delete` is represented as selected-source removal without replacement,
6. no `remove` operation kind or alias is encoded.

## Notes

- This slice describes provider capability reporting. It does not claim that
  every existing provider projection has already implemented all three
  operations.
- Provider-specific adoption should follow by updating each provider backend to
  project or execute the triad where supported.
