## Slice 958: Ruby Declaration Kind-Aware Matching

Match Ruby declarations by both declaration kind and name so same-named classes
and modules are not merged into each other.

### Why

- `class Config` and `module Config` share a constant name but are different
  declaration forms
- merging their bodies silently can change the destination program shape
- class matching refinements need this exact guardrail before namespace or fuzzy
  declaration matching

### Rules

1. declaration merge identity includes declaration kind and declaration name
2. destination-owned declaration text wins for same kind/name matches
3. same-name declarations with different kinds are not matched
4. unmatched template declarations are appended as template-owned declarations
