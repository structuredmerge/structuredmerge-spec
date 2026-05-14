# Slice 749: JSONC Fixture Coverage Verification

## Goal

Verify current fixture coverage for old `jsonc-merge` value and identify the
remaining fixture gaps before documentation is ported.

## Existing Coverage

Current portable fixtures cover:

- JSONC line and block comments are accepted during parse,
- JSONC trailing commas are rejected,
- JSONC comments do not change the structural owner model,
- JSON object insertion behavior exists for strict JSON and applies as the
  current merge baseline after JSONC comments are stripped.

## Missing Coverage

The old `jsonc-merge` package had behavior that is not yet represented by
active portable fixtures:

- comment-preserving merge output,
- freeze and unfreeze marker behavior in JSONC line comments,
- JSONC object insertion while preserving leading and inline comments,
- JSONC emitter formatting and comment placement,
- template-wins conflict handling with comments,
- removal-mode comment promotion,
- legacy Ruby `Jsonc::Merge` compatibility wrapper behavior.

## Decision

Do not claim the missing behavior in generated READMEs yet.

The current `json-merge` README may claim JSONC parse and owner-structure
support. JSONC comment-preserving merge, freeze blocks, emitter behavior, and
advanced conflict resolver behavior remain fixture gaps and must be added as
new behavior slices before implementation or user-facing examples.

## Boundaries

- This slice verifies coverage; it does not implement the missing behavior.
- Existing JSONC parse and structure fixtures remain the only active JSONC
  conformance claims.
- The old reproducible JSONC examples are preserved as source references for
  future behavior fixtures.
