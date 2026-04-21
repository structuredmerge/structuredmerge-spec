# Slice 253: Generic Merge Contract Extension

## Goal

Define a stable extension shape for family-specific merge behavior that cannot
yet be expressed as a parser-agnostic shared contract.

## Contract

1. a shared merge contract MAY expose family-specific behavior through a
   generic extension entry
2. each generic extension entry MUST expose a stable `kind`
3. each generic extension entry MUST expose `subject_ref` that identifies the
   shared contract subject to which the extension applies
4. each generic extension entry MUST expose `capabilities` as an explicit list
   of generic operations or review/apply behaviors that shared tooling may
   perform without understanding family-local payload details
5. each generic extension entry MAY expose `metadata` for stable descriptive
   fields that do not change the logical meaning of the opaque family payload
6. each generic extension entry MAY expose `custom_payload` for family-owned
   semantics that are not yet portable across parsers or runtimes
7. shared tooling MUST preserve extension entry identity, ordering, and payload
   bytes or values across review, default, replay, and apply-plan transport
   unless a shared slice for that `kind` defines stronger normalization rules
8. shared tooling MUST NOT infer family-local meaning from `custom_payload`
   beyond the declared generic `capabilities`

## Notes

- This slice creates a structured fallback for not-yet-portable behavior.
- A generic extension entry may later graduate into a dedicated shared shape
  once multiple families can use the same contract unchanged.
