# Merge Lexicon

This file is a practical lexicon snapshot for implementation work. It is not a
replacement for `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md`; it is a short,
implementation-oriented bridge document derived from it.

## Source Of Truth

Primary source:

- `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md`

Secondary planning inputs:

- `AST_MERGE_SPEC_ALIGNMENT_TODOS.md`
- `REMOVAL_MODE.md`
- `LICENSE_TEMPLATE_PLAN.md`

## Core Terms

### Document

The parsed or unparsed source unit being analyzed or merged.

Examples:

- Ruby source file
- JSON or JSONC document
- Markdown document
- Plain text document

### Analysis

The implementation-specific representation produced from a document before
matching and merge resolution.

Examples:

- Tree-sitter parse tree plus comment metadata
- Text block segmentation plus normalized spans

### Dialect

A declared parse or merge variant within one document family that changes
observable acceptance or interpretation rules without changing the high-level
document family itself.

Examples:

- `json` vs `jsonc`
- strict vs extension-enabled parse modes

### Normalized Source

A canonicalized text form produced before or during analysis for the purpose of
portable comparison, validation, or matching.

Normalized source is an observable behavior artifact. It is not necessarily the
same as the final rendered output.

### Node

A structural unit eligible for matching, conflict resolution, rendering, or
diagnostic reporting.

Examples:

- AST pair
- array element
- Markdown block
- text paragraph

### Match

An implementation decision that two nodes from template and destination are the
same logical unit for merge purposes.

### Stable Path

A reproducible location identifier within an analyzed document that can be used
as an observable matching surface.

Examples:

- JSON Pointer-style owner paths
- normalized owner paths derived from syntax trees

### Refiner

A post-parse matching helper that improves baseline structural matching using
content similarity, signatures, or specialized heuristics.

### Match Phase

The declared stage of a matching decision.

Examples:

- `exact`
- `refined`

### Refined Match

A match produced by a declared refinement pass after baseline matching has
already consumed exact or primary candidates.

### Match Candidate

An exposed identity hint that may support matching in later or richer policies
without yet being the sole match rule in the current slice.

Example:

- a JSON object member `match_key` when the baseline matcher still uses stable
  path equality

### First-Unmatched Matching

A matching policy in which repeated equivalent candidates are consumed in order,
and each new match uses the first candidate that has not already been matched.

### Freeze Region

A region whose destination content is preserved regardless of template content.

### Comment Capability

The representation and rules an implementation uses to preserve, attach,
replay, or synthesize comments.

### Diagnostic

Structured information about parse problems, merge ambiguity, fallback,
corruption detection, or skipped behavior.

### Fallback

A declared recovery path applied after baseline processing fails for a specific
state class.

Fallback is an observable behavior decision. It is not the same as baseline
preprocessing, and it must not silently widen the accepted syntax surface unless
the behavior contract explicitly allows it.

### Preprocessing

A constrained transformation applied before parser or matcher execution in order
to realize a declared contract in a portable way.

Examples:

- stripping JSONC comments before strict JSON parsing
- newline normalization before text block analysis

Preprocessing is acceptable only when its effect is part of the observable
contract and does not silently repair prohibited syntax.

### Removal Mode

The policy governing whether destination-only or template-only nodes are
retained, removed, or conditionally emitted.

### Render

The final emission step that turns resolved nodes back into document text.

### Canonical Render

A deterministic rendered form chosen for conformance testing or stable
cross-implementation comparison.

Canonical render is an observable comparison surface. It need not be the final
presentation-oriented render used by all consumers.

## Implementation Contracts

Every language implementation should define equivalents for:

1. Document input contract
2. Analysis contract
3. Node wrapper contract
4. Matching/refinement contract
5. Freeze handling contract
6. Comment capability contract
7. Diagnostic contract
8. Render contract

## Deliberate Constraints

- MVP implementations should prefer tree-sitter-backed analysis where practical.
- Native parser alternatives may be used later, but tree-sitter is the baseline
  portability target for v1.
- Templating/scaffolding is a later layer, not part of the core lexicon MVP.

## Cross-Implementation Observations

Observations from slices 02 through 08:

- Portable runtime contracts for diagnostics and results stabilize faster than
  parser API contracts and should be specified earlier.
- Observable parse behavior can be aligned before tree-sitter integration is
  aligned, which argues for behavior-first conformance slices.
- `dialect` is a first-class concept rather than an implementation detail.
- `normalized_source` is useful as a portable comparison surface and should be
  treated as part of analysis contracts where relevant.
- Controlled preprocessing is sometimes required for portability, but silent
  repair must remain outside baseline conformance unless explicitly declared.
- Stable path semantics became important as soon as structure was exposed, which
  argues for making path contracts explicit before richer matching policies.
- Exposed match candidates and actual match rules should remain distinct until
  conformance evidence shows they can safely collapse.
- For text-like content, destination-order preservation and first-unmatched
  consumption are observable behaviors that should be specified explicitly when
  repeated blocks are possible.
- For text-like content, exact anchor matching and refined matching should stay
  distinct in the observable result model even when both phases contribute to
  merge output.
- Recovery behavior can be standardized independently from baseline parser
  strictness, but only if fallback activation, scope, and resulting diagnostics
  are explicit.
