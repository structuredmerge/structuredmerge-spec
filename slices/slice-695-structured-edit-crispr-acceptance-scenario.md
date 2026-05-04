# Slice 695: Structured Edit CRISPR Acceptance Scenario

## Goal

Define a provider-neutral CRISPR acceptance scenario that validates the shared
structured-edit surface instead of a Prism, Markly, or other backend-specific
projection API.

## Shared Behavior

This slice defines one shared CRISPR acceptance surface:

1. `replace` rewrites exactly one selected AST-owned block,
2. `insert` adds explicit payload at an identified insertion point,
3. `delete` removes exactly one selected AST-owned block,
4. ambiguous matches fail closed without changing content,
5. the scenario uses shared request, result, application, and execution-report
   contracts so Go, Rust, TypeScript, and Ruby can carry the same real-world
   use case independently of parser backend.

## Notes

- The fixture is intentionally provider-neutral and uses `generic_ast` labels.
- Parser-specific adoption should prove it can produce the same shared
  contract shape; it should not require Prism/Markly-style projection APIs.
- No `remove` operation kind or alias is introduced.
