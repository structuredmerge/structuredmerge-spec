# Slice 703: Ruby Gemspec Field Policy Acceptance

## Goal

Define provider-neutral native policy behavior for supplied gemspec field updates.

## Shared Behavior

This slice covers gemspec field policies that can run natively when a wrapper
has already supplied replacement values:

1. replace existing literal field assignments inside the Gem::Specification
   block,
2. insert missing literal field assignments near the identity/version fields,
3. preserve non-placeholder destination `summary` and `description` values when
   the supplied replacement is only a placeholder,
4. delete deprecated singular `spec.license` when canonical plural
   `spec.licenses` exists,
5. keep all behavior single-file and deterministic.

## Notes

- Deriving replacement values remains wrapper work.
- This slice does not cover dependency-section or files-assignment
  harmonization.
