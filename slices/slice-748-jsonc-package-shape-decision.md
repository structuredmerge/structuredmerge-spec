# Slice 748: JSONC Package Shape Decision

## Goal

Decide whether old `jsonc-merge` remains a separate package, a backend variant,
or fixture-only behavior in the current structured-merge workspace.

## Current State

The active JSON implementations in Go, Rust, TypeScript, and Ruby model JSONC
as a `json-merge` dialect:

- feature profiles list both `json` and `jsonc`,
- JSONC parse fixtures accept comments,
- JSONC structure fixtures confirm comments do not change owner extraction,
- strict JSON tree-sitter-language-pack adapter support currently rejects
  `jsonc` dialect requests where that backend lacks JSONC support.

There is no active `jsonc-merge` package in the current language lanes.

## Decision

JSONC is a dialect of the current JSON family, not a separate active
cross-language package.

The old `jsonc-merge` package is superseded as an implementation package. Its
remaining value is:

1. JSONC fixtures under `fixtures/jsonc/`,
2. generated `json-merge` README notes explaining JSONC dialect support,
3. optional Ruby-only compatibility wrapper behavior for legacy
   `require "jsonc/merge"` callers if a current packaging task explicitly
   asks for that wrapper,
4. old comment-preservation, freeze-block, emitter, and conflict-resolver cases
   as future fixture candidates.

## Non-Goals

- Do not create Go, Rust, or TypeScript `jsonc-merge` packages.
- Do not document `jsonc-merge` as an active package in generated family
  support tables.
- Do not claim JSONC comment-preserving merge output until fixtures and active
  implementations support it.

## Follow-Up

The next JSONC task is fixture verification for comments, freeze blocks, object
insertion, emitter, and conflict resolver behavior. Existing parse and
structure fixtures cover only a subset of the old package value.
