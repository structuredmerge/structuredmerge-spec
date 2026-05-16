# Slice 839: Merge Gem Authoring Guide Contract

## Goal

Split the old `ast-merge` `BUILD_A_MERGE_GEM.md` guide into surviving
cross-language contracts, Ruby-only conveniences, contributor guidance, and
retired old-shape requirements.

## Contract

The current StructuredMerge family keeps these authoring rules from the old
guide:

- parse into a normalized node tree before merge orchestration;
- match duplicate signatures with ordered cursors instead of collapsing by
  signature;
- scope recursive merges to the matched container being merged;
- make template-only insertion position-aware around matched anchors;
- prefer shared substrate primitives for comments, layout, freeze/frozen
  regions, partial-template flows, nested delegated merges, and text fallback;
- fixture behavior before implementation claims;
- route shared behavior to the substrate, family behavior to the family package,
  backend defaults to the wrapper, and parser-local behavior to the leaf
  provider.

The current family does not keep these old requirements as mandatory public
shape:

- every implementation must expose Ruby classes named `SmartMerger`,
  `FileAnalysis`, `ConflictResolver`, `MergeResult`, or `Emitter`;
- every implementation must subclass the old Ruby base classes;
- every implementation must register with the old Ruby `MergeGemRegistry`;
- old RSpec shared examples are the cross-language conformance mechanism.

Those Ruby constructs may remain useful adapter conveniences, but fixtures,
provider profiles, normalized tree contracts, and execution reports are the
portable authoring surface.
