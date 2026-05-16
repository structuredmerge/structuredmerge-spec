## Slice 960: Ruby Duplicate Method Shadowing Projection

Project Ruby duplicate method definitions in the same scope as shadowing
metadata instead of generic matcher ambiguity.

### Why

- Ruby does not support overloads by arity or parameter shape
- a later method definition with the same receiver/name shadows earlier
  definitions in the same scope
- generic matchers need this fact so duplicate Ruby methods do not look like
  language-neutral ambiguity
- users still need diagnostics because shadowed definitions are often
  accidental

### Rules

1. duplicate direct methods are grouped by receiver-aware method signature
2. the last method in source order is the effective method
3. earlier same-signature methods are projected as shadowed methods
4. shadowing metadata is advisory analysis input for matchers and diagnostics
   and does not remove source text
