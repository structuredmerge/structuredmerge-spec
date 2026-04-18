# Slice 01: Foundation

## Goal

Establish the first shared conformance slice across TypeScript, Rust, and Go.

This slice is intentionally shallow. It defines structure, terminology, and
package boundaries without committing to deep implementation details yet.

## Scope

Included:

- shared fixture layout for `text`, `json`, and `jsonc`
- monorepo/workspace shape in each target language
- package/crate/module placeholders for:
  - tree-sitter adapter
  - merge core
  - text merge
  - JSON merge
- placeholder exported surface for each package

Excluded:

- real parsing
- real merging
- CLI tools
- scaffolding/templating
- advanced ruleset execution

## Conformance Objective

Every language family should agree on the same first four library boundaries:

1. `tree-haver`
2. `ast-merge`
3. `text-merge`
4. `json-merge`

This slice succeeds when all three language families:

- expose those four units in a monorepo
- document the same role for each unit
- can point at the same shared fixture directories

## Notes

- TypeScript package names may include `-ts`.
- Rust crate names may include `-rs`.
- Go uses package names that fit Go conventions, even when the repo name is
  `structuredmerge-go`.
- The DRAFT should be refined from cross-language friction discovered while
  keeping this slice intentionally behavior-light.
