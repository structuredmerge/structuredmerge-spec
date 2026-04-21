# Slice 268: Grammar-Keyed Ruby And Markdown Portable Suites

## Goal

State the migration rule for the current Ruby and Markdown portable suites.

## Contract

1. the current base Markdown portable suite MUST be understood as the portable
   descriptor `{ kind: "portable", subject: { grammar: "markdown" } }`
2. the current nested Markdown portable suite MUST be understood as the
   portable descriptor
   `{ kind: "portable", subject: { grammar: "markdown", variant: "nested" } }`
3. the current base Ruby portable suite MUST be understood as the portable
   descriptor `{ kind: "portable", subject: { grammar: "ruby" } }`
4. the current nested Ruby portable suite MUST be understood as the portable
   descriptor
   `{ kind: "portable", subject: { grammar: "ruby", variant: "nested" } }`
5. shared tooling MUST refer to those suites by those descriptors directly and
   MUST NOT introduce family-named portable aliases as a separate identity

## Notes

- This slice does not choose one Markdown provider.
- This slice does not prevent Ruby or Markdown provider-specific named suites.
- It only fixes the shared portable identity for those suites.
