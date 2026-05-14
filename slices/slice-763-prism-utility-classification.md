# Slice 763: Prism Utility Classification

## Goal

Classify old `reference/prism-merge` utilities as portable Ruby conformance
behavior, Prism provider internals, or Kettle/Jem recipe-specific behavior.

## Portable Ruby Family Behavior

These old values should become or remain `ruby-merge` family behavior only when
fixture-backed:

- Ruby parse/profile/plan/manifest behavior.
- module/class/method owner extraction.
- path/equality owner matching.
- top-level declaration merge.
- top-level DSL/Gemfile merge.
- Ruby doc-comment surface discovery.
- delegated child operations for YARD examples.
- nested merge and reviewed nested merge.
- magic comment preservation.
- `:nocov:` ownership and preservation.
- recursive class/module body merge.
- begin/rescue clause semantics if retained.
- gemspec field and dependency merge policies.

## Prism Provider Internals

These old utilities are provider-internal unless fixtures promote behavior to
the family contract:

- `FileAnalysis`
- `NodeWrapper`
- `NodeTypeNormalizer`
- `SourceLineLookup`
- `NodeEmissionSupport`
- `NodeBodyLayout`
- `NestedStatementWalker`
- `BeginNodeStructure`
- `BeginNodeRescueSemantics`
- `BeginNodeClauseBodySupport`
- `BeginNodeClauseBodyMerger`
- `BeginNodeClauseHeaderEmitter`
- `BeginNodeMergePlanner`
- `BeginNodePlanEmitter`
- `Comment::*`
- `MagicCommentSupport`
- `NocovNode`
- `NocovWrapper`
- `FreezeNode`
- `MethodMatchRefiner`
- `RecursiveNodeBodyMerger`
- `RecursiveMergePolicy`
- `SmartMerger`

## Kettle/Jem Recipe Or Tooling Behavior

These old utilities are not generic Ruby merge claims without dedicated recipe
fixtures:

- `GemspecVarRenamer`
- `PartialTemplateMerger`
- `PartialTemplateNode`
- `ScaffoldChunkRemover`
- `RubyDocSurfaceAnalyzer`
- `TopLevelMergeRunner`
- `BlockDirectiveDetector`
- comment-only file merge behavior when used for generated template artifacts.

Some of these may still be valuable, but their destination is likely
`kettle-jem` recipe tooling or source-template workflows unless a portable Ruby
fixture says otherwise.

## Retired As Public Contract

Do not port old private helper class names as generated README claims. The
public cross-language contract is fixture-backed behavior.

## Decision

Use `ruby-merge` for fixture-backed Ruby source semantics and `prism-merge` for
the Ruby/Prism provider package. Defer old Prism internals and recipe-specific
helpers until the next fixture coverage pass determines which behaviors still
need portable fixtures.
