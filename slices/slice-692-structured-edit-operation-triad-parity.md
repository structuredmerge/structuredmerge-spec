# Slice 692: Structured Edit Operation Triad Parity

## Goal

Standardize the generic structured-edit operation triad used by CRISPR parity
scenarios without assigning the behavior to any one family or provider backend.

## Shared Behavior

This slice defines one shared operation-triad parity surface:

1. `insert` adds explicit payload text at a destination or fallback
   destination,
2. `replace` captures a selected target and rewrites it with explicit payload
   text,
3. `delete` captures a selected target and removes it without replacement,
4. the triad is family-neutral and applies to AST-shaped structured edits,
5. `delete` is the canonical wire and API operation kind.

## Notes

- Do not encode `remove` as a supported operation kind or alias. Human-facing
  requests for removal should map to canonical `delete` before reaching the
  shared contract.
- Markdown, Ruby, and other families may provide representative projections,
  but the operation vocabulary is owned by the shared structured-edit
  substrate.
