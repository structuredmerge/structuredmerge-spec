# Slice 264: Grammar-Keyed Portable Suite Identity

## Goal

Make the shared identity of a portable conformance suite depend only on its
portable descriptor shape.

## Contract

1. a portable conformance suite descriptor MUST be identified by its `kind` and
   `subject`
2. for ordinary portable family suites, `subject` MUST include `grammar`
3. if a portable suite distinguishes additional shared meaning such as a nested
   or delegated surface, that distinction MUST appear inside `subject`
4. shared planning, reporting, review, reviewed-default, and replay contracts
   MUST treat the descriptor shape as the canonical suite identity
5. shared tooling MUST identify a portable suite through the descriptor itself
   and MUST NOT require a secondary suite-name indirection

## Notes

- The shared identity is the portable descriptor itself, for example
  `{ kind: "portable", subject: { grammar: "markdown" } }`.
