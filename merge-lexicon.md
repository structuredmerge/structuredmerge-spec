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

### Fallback Scope

The declared boundary of states and inputs for which a fallback is allowed.

Fallback scope is part of conformance behavior. A recovery path that succeeds
outside its declared scope is a contract violation, not a benign extension.

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

### Array Policy

The declared rule governing how arrays are resolved when both template and
destination provide an array value at the same merge location.

Array policy is separate from object member merge behavior even when both appear
in the same document family.

### Policy Surface

The merge-behavior dimension to which a named policy applies.

Examples:

- fallback scope
- array resolution

### Policy Reference

An observable name binding between a policy surface and one declared policy on
that surface.

### Policy Reporting

The optional exposure of active policy references on a parse or merge result.

### Policy Support

The optional exposure of which policy references a backend, adapter, or merge
surface can support, independent of which ones were active in a particular
result.

### Feature Profile

A normalized descriptive view of supported merge-relevant behavior intended for
inspection, conformance reporting, or feature negotiation.

### Family Feature Profile

A normalized descriptive view of a document-family merge package, independent of
any single backend adapter.

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
- Once a fallback exists, its non-applicability cases become just as important
  as the success path because silent scope growth is otherwise hard to detect.
- Array handling should become an explicit policy surface before any
  element-level array matching is introduced, otherwise later policy expansion
  will be hard to reason about.
- Once multiple policy surfaces exist, they need a shared neutral vocabulary so
  implementations do not encode policy identity as format-local strings.
- Policy vocabulary becomes substantially more useful once results can report
  which policies were active for a given operation.
- Active policies and supported policies are different surfaces and should stay
  distinct: one is result-specific, the other is capability metadata.
- Once adapter capability surfaces become explicit, a normalized feature profile
  becomes useful as the compact reporting surface that ties backend identity,
  dialect support, and supported policies together.
- Family-level profiles are a useful second reporting surface after adapter
  profiles because they describe package behavior without leaking backend
  identity into every consumer-facing report.
