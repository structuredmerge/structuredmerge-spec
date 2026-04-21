# Slice 252: Portable Logical Merge Result

## Goal

Define the conformance target for shared merge contracts across TypeScript,
Rust, Go, and Ruby implementations.

## Contract

1. a shared merge contract MUST expose enough stable identity, decision,
   delegation, and apply semantics for independent implementations to compute
   the same logical merge result for the same document family input
2. this specification MUST standardize outcome-relevant observable shapes and
   invariants without requiring one parser architecture, traversal order, or
   runtime implementation strategy
3. implementations MAY differ in internal algorithms, helper structures,
   intermediate normalization, and execution order as long as those differences
   do not change the logical merge result or the normalized review/apply
   surfaces defined by shared slices
4. language, runtime, parser, and grammar-specific discovery or interpretation
   rules SHOULD remain in family merge gems unless the behavior can be stated as
   a parser-agnostic shared shape
5. when family-specific behavior cannot yet be expressed as a parser-agnostic
   shared shape, the shared contract MAY carry it through a stable generic
   extension shape with explicit kind, subject identity, declared generic
   capabilities, and family-owned opaque payload
6. canonical review, default, replay, and apply planning MUST consume the
   shared outcome-relevant shapes and MUST NOT rely on implementation-local
   heuristics or family-local naming when portable fields can carry the same
   meaning

## Notes

- This slice defines a portable contract, not a portable engine.
- Conformance for this layer is about equivalent logical results and normalized
  observable state, not identical internal execution traces.
