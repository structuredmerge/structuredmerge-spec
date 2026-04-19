# Slice 26: Tree-sitter JSON Adapter

## Goal

Define the first tree-sitter-backed JSON adapter baseline.

## Scope

- define a minimal tree-sitter-backed json adapter target
- preserve current observable parse and reporting behavior
- treat backend adoption as an implementation detail behind existing contracts

## Contract

This slice defines one narrow backend-backed adapter contract:

1. a json family package MAY expose a tree-sitter-backed strict-json parse entrypoint
2. that entrypoint MUST preserve the same observable `JsonAnalysis` shape already
   defined by earlier slices when parsing succeeds
3. syntax errors discovered by the backend MUST still surface as
   `parse_error`
4. unsupported dialect requests MUST surface as `unsupported_feature`
5. backend-backed parsing remains narrower than full json family support until
   dialect and comment behavior are explicitly aligned

## Notes

- The current portable behavior contracts should remain authoritative when this
  backend-backed entrypoint is used.
- This slice does not require backend identity to be present in the family
  analysis result. It only requires that the backend-backed entrypoint preserve
  existing observable json-family behavior.
