# Slice 1002: Source-Family Prior-Art Notes

StructuredMerge adopts these Weave lessons for source-family merges:

- owner and interstitial regions are first-class merge surfaces;
- fallback has an explicit floor and must be reported;
- post-merge validation is separate from merge planning and rendering;
- matching should expose confidence rather than hiding ambiguity;
- nested container merge should be scoped and declared.

StructuredMerge adopts these Mergiraf lessons for source-family merges:

- fine-grained AST matching is an optional profile, not the only architecture;
- successor/PCS-style child ordering is a backend strategy under a declared
  merge surface;
- commutative parent handling is only valid when the ruleset declares it;
- rendering and conflict-marker compatibility are part of the merge contract.

Explicit non-goals:

- do not make entity-level merge the only architecture;
- do not treat formatter output as semantic validation;
- do not mark order-sensitive constructs clean by default;
- do not hide fallback or validation failures.
