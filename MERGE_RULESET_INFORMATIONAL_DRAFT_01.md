# draft-pboling-merge-ruleset-01

**Intended status:** Informational  
**Expires:** N/A

# A Vocabulary and Compact Ruleset Format for Structured Document Merge

## Abstract

This document defines a vocabulary and compact ruleset format for describing merge behavior for structured document languages. Existing standards work largely addresses patch transport and format-specific change application. It does not define a portable way to express structural matching, non-structural ownership, logical-owner preservation, layout preservation, repair-policy handling, reviewable unresolved outcomes, or merge-surface and delegation declarations across document families.

This document specifies:

1. a common vocabulary for structured document merge,
2. capability classes for merge-relevant semantic surfaces, support boundaries, and declared limitations,
3. a compact declarative ruleset format,
4. optional vocabulary for comment-style, render-family, capability, logical-owner, repair-policy, merge-surface, delegation, and review-state handoff concepts, and
5. conformance expectations for ruleset consumers.

The goal is not to standardize one universal merge algorithm for all languages. The goal is to standardize the terms and ruleset structure needed so merge engines written in different implementation languages can interpret the same merge contract.

## Status of This Memo

This memo provides information for the Internet community. It does not specify an Internet standard of any kind.

## Table of Contents

1. [Introduction](#1-introduction)  
2. [Conventions and Requirements Language](#2-conventions-and-requirements-language)  
3. [Problem Statement](#3-problem-statement)  
4. [Scope](#4-scope)  
5. [Terminology](#5-terminology)  
6. [Capability Classes](#6-capability-classes)  
7. [Ruleset Model](#7-ruleset-model)  
8. [Ruleset Syntax](#8-ruleset-syntax)  
9. [Ruleset Semantics](#9-ruleset-semantics)  
10. [Normative Example](#10-normative-example)  
11. [Additional Informative Examples](#11-additional-informative-examples)  
12. [Conformance Requirements](#12-conformance-requirements)  
13. [Implementation and Adoption Considerations](#13-implementation-and-adoption-considerations)  
14. [Interoperability Considerations](#14-interoperability-considerations)  
15. [Security Considerations](#15-security-considerations)  
16. [IANA Considerations](#16-iana-considerations)  
17. [Relationship to Existing Standards](#17-relationship-to-existing-standards)  
18. [Rationale for Informational Status](#18-rationale-for-informational-status)  
Appendix A. [Minimal Ruleset Grammar](#appendix-a-minimal-ruleset-grammar)  
Appendix B. [Conformance Matrix](#appendix-b-conformance-matrix)

## 1. Introduction

Structured document formats such as YAML, JSON, TOML, XML, shell configuration files, dotenv files, Markdown, and type-signature formats often require merge behavior that is more semantics-aware than line-based diff/merge and more presentation-aware than patch application.

Across these formats, the same practical questions recur:

1. Which syntax elements are merge-relevant?
2. How are corresponding elements matched?
3. Which render family or output-shaping contract applies?
4. How are comments or other non-structural annotations discovered?
5. How are comments, annotations, and blank-line gaps attached to structural elements?
6. When a structural element is removed, what happens to adjacent non-structural content?
7. Which syntax-specific limitations, support boundaries, or divergences are intentional rather than erroneous?

In many implementations, answers to those questions are encoded as implicit local code rather than explicit portable declarations. This document proposes a compact ruleset format for expressing those answers directly.

## 2. Conventions and Requirements Language

The key words **MUST**, **MUST NOT**, **REQUIRED**, **SHALL**, **SHALL NOT**, **SHOULD**, **SHOULD NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in RFC 2119 and RFC 8174 when, and only when, they appear in all capitals.

## 3. Problem Statement

Existing patch specifications define ways to describe and apply changes to a document or resource. They do not define a common model for merge semantics across structured document languages, especially where:

- comments are not part of the native editable syntax model,
- blank-line gaps carry ownership meaning,
- some artifacts are preserved by logical reference rather than by direct structural presence,
- multiple parser backends expose different levels of fidelity,
- syntactic families share behavior but not exact tree structures.

As a result, merge behavior is repeatedly reimplemented in incompatible ways even when the conceptual model is substantially shared.

The same gap appears when a merge cannot or should not be finalized immediately. A tool may need to preserve reviewable unresolved state, hand it to another process or user-facing system, and later resume from the same merge context. Without common conceptual vocabulary for that handoff, systems tend to rely on implementation-local case numbering or positional coincidence rather than explicit semantic binding.

## 4. Scope

This document standardizes:

- merge vocabulary,
- capability classes,
- a compact ruleset description format,
- the meaning of core ruleset terms,
- optional declarations for comment style, render family, capability statements, logical-owner declarations, repair-policy declarations, merge-surface declarations, and delegation policies,
- conformance expectations for ruleset consumers.

This document does not standardize:

- a universal parser API,
- a transport protocol,
- a patch document format,
- a single mandatory merge algorithm,
- a conflict- or unresolved-resolution UI,
- a persistence format for saving reviewable unresolved runtime state,
- byte-identical output across all implementations.

This document also does not require any consumer to externalize unresolved runtime state. It only defines the conceptual vocabulary needed so that, when such state is exposed, tools can describe and evaluate it without depending on one implementation's private terminology.

## 5. Terminology

### 5.1 Structural Owner

A syntax element that may own attached non-structural content such as comments or adjacent layout gaps.

Examples include:

- a YAML mapping entry,
- a TOML pair,
- a shell assignment,
- an XML element,
- a Markdown block node.

### 5.2 Logical Owner

A merge-relevant artifact whose preservation or removal is governed by semantic rules other than ordinary structural presence.

Example: a Markdown link definition that SHOULD remain if references to it remain.

### 5.3 Match Key

The identity used to determine whether source and destination owners correspond.

Examples include:

- key name,
- normalized path,
- structural signature,
- attribute tuple,
- normalized reference label.

A consumer MAY expose additional match candidates that are not yet the sole
normative match key in a given behavior profile, so long as the actual match
rule remains explicit.

Consumers MAY also expose whether an accepted correspondence came from a
baseline rule or from a declared refinement pass, so long as the distinction is
descriptive rather than a hidden substitute for the normative match key.

### 5.3b Stable Path

A reproducible location identifier within an analyzed document that MAY be used
as an observable matching surface.

Examples include JSON Pointer-style owner paths or normalized structural paths
derived from syntax trees.

When a consumer uses stable path as part of a behavior profile, the path format
and normalization rules SHOULD be explicit enough for cross-implementation
conformance testing.

### 5.3a Dialect

A declared parse or merge variant within a document family that changes
observable acceptance or interpretation rules without changing the broader
document family.

Examples include strict JSON versus JSON-with-comments handling, or other
extension-controlled parse modes that share the same high-level merge family.

### 5.4 Comment Region

A grouped comment unit. Region kinds include:

- `preamble`
- `leading`
- `inline`
- `trailing`
- `postlude`
- `orphan`

### 5.5 Gap

A blank-line region between structural owners or at a document boundary that MAY carry ownership semantics.

### 5.6 Read Strategy

The rule by which comments are obtained from the source representation.

### 5.7 Attachment Strategy

The rule by which comments and layout gaps are attached to owners.

### 5.8 Owner Selector

The rule that determines which syntax elements participate as merge-relevant owners.

### 5.9 Capability Declaration

A named declarative statement about a merge-relevant semantic surface, support boundary, limitation, divergence, or intentional non-support case in a ruleset.

A capability declaration may therefore be used to express either:

- an additional semantic surface relevant to conformance, or
- an explicitly declared support boundary, divergence, or limitation relevant to conformance.

### 5.10 Portable Write Layer

A behavioral class in which merged output is emitted according to the declarative ruleset contract, without requiring direct in-place mutation of native syntax-owned annotation or attachment structures.

This term is behavioral rather than architectural. Its internal realization is out of scope.

### 5.11 Feature Profile

A derived summary of the merge-relevant behavior declared by a ruleset.

A feature profile typically summarizes:

- owner selector,
- match key,
- read strategy,
- attachment strategy,
- comment style, when declared,
- render family, when declared,
- declared capability statements,
- declared logical owners,
- declared repair policies,
- declared merge surfaces and delegation policies.

The feature profile MAY be produced by tooling rather than written directly in the compact ruleset syntax.

When exposed, a feature profile is a **normalized descriptive view** of the declared contract. It is intended for inspection, conformance reporting, diagnostics, or feature negotiation. It is not itself the source of normative merge semantics; the ruleset remains the normative declaration.

A feature profile MAY additionally include derived classification metadata such as:

- owner-selector family,
- match-key family,
- attachment-strategy family,
- whether capability statements are declared,
- whether the ruleset is structural-only,
- whether the ruleset is layout-aware,
- whether logical-owner behavior is declared,
- whether repair-policy behavior is declared,
- whether merge surfaces or delegation policies are declared.

Such derived metadata **SHOULD** be computed only from declared ruleset meaning or explicitly documented normalization rules. It **MUST NOT** encode implementation-local heuristics as if they were ruleset semantics.

If the underlying ruleset omits optional directives because those surfaces are outside the declared merge contract, an exposed feature profile SHOULD preserve that omission rather than synthesize values. For example, it SHOULD not invent a comment family when `comment_style` is absent or a render family when `render` is absent.

Where an implementation supports aggregate conformance or capability reporting
across families, it MAY additionally expose a **default family context** derived
from a declared family feature profile. Such defaulting is appropriate only when
the derived context does not introduce merge ambiguity or silently change merge
semantics. An implementation that exposes such defaulting SHOULD also expose
that assumption as a manifest-level diagnostic rather than silently omitting the
undeclared context.

Implementations MAY also offer an **explicit context mode** in which family
contexts must be declared directly and derived defaults are not allowed. In
that mode, missing contexts are configuration errors rather than recoverable
defaults.

### 5.12 Merge Surface

A merge-relevant region within a document that MAY be merged under a distinct sub-ruleset or delegated merge contract.

Examples include:

- a fenced code block inside Markdown,
- a documentation comment body,
- an embedded configuration fragment,
- a heredoc or multiline literal with a known language.

### 5.13 Delegation Policy

A declarative rule describing whether and how a merge surface is handed to another merge contract.

Delegation policy is distinct from parser behavior. It describes observable merge responsibility, not a particular implementation call graph.

### 5.14 Repair Policy

A declarative rule describing how a consumer handles ambiguous, overlapping, or historically corrupted merge states that fall outside the ideal declarative ownership model.

Typical repair-policy outcomes include:

- preserve and continue,
- preserve and warn,
- fail,
- defer completion and expose a reviewable unresolved outcome,
- apply a declared healing transformation.

### 5.14a Normalized Source

A canonicalized text form produced before or during analysis for the purpose of
portable comparison, validation, structural matching, or conformance testing.

Normalized source is an observable behavior artifact. It is not necessarily the
same as either the original input bytes or the final rendered output.

### 5.14b Preprocessing

A constrained transformation applied before parser or matcher execution in order
to realize a declared merge contract in a portable way.

Examples include comment stripping for a comment-tolerant dialect before
handoff to a stricter native parser, or newline normalization before text-block
analysis.

Preprocessing MAY be used by a consumer when its effect is part of the declared
or documented observable contract. A consumer MUST NOT silently repair syntax
that the declared contract says is invalid unless an explicit repair policy
permits that behavior.

### 5.14c Process Analysis

A lightweight extracted view produced by a parser backend before full family
analysis or merge resolution.

Typical process-analysis outputs include:

- top-level structure items,
- import/include statements,
- parser diagnostics attached to extracted spans.

Process analysis is especially useful for source-language families that need a
portable ownership and matching baseline before richer AST-aware merge behavior
is declared.

### 5.14d Family Backend

A concrete parser-backed implementation path used by one merge family.

Examples include:

- a tree-sitter-backed adapter,
- a native language parser,
- another stable parser with the same family-facing merge contract.

A family backend is an implementation concern, but it may have observable
capability or conformance consequences. A consumer MAY therefore expose backend
identity and backend-limited conformance results without changing the family
contract itself.

A family MAY also expose a backend-specific feature profile view for
conformance or planning surfaces, so long as the view remains consistent with
the family contract rather than leaking parser-internal detail.

### 5.14e Backend Requirement

A conformance-case constraint that limits selection to a named family backend.

Backend requirements are evaluated at case-selection time alongside dialect and
policy requirements. A consumer MUST NOT silently select a backend-limited case
when a different backend is active.
Backend requirements MAY be declared directly on a case or propagated through a
manifest entry that plans such a case.

### 5.15 Unresolved Outcome

A runtime merge outcome in which a consumer preserves one or more reviewable cases instead of collapsing immediately to one emitted result.

An unresolved outcome MAY arise from direct conflict, ambiguity, policy-required review, unsupported capability boundaries, or other situations where the consumer intentionally preserves choice for a caller or later review step.

An unresolved outcome MAY still carry a provisionally emitted result so long as the preserved review cases explicitly identify that provisional winner as a default pending review rather than as a silently final resolution.

An unresolved outcome MAY be completed within the producing runtime or resumed later through externalized review state if the consumer chooses to expose such a handoff surface.

An unresolved outcome is a runtime-facing state in this draft. It is not, by itself, a standard ruleset directive or a required persistence format.

### 5.16 Resolution Case

A single reviewable item within an unresolved outcome.

A resolution case records the competing candidates, interpretations, or policy branches that remain open, together with a reason classification and any provisional default that would apply absent explicit review.

When a consumer exposes structured runtime state, a resolution case SHOULD be capable of identifying at least:

- the competing candidate branches or values,
- the reason classification,
- any provisional winner/default,
- enough local context to reconnect the case to the affected merge surface,
- and, when intended for replay beyond the producing runtime, a stable identity or equivalent compatibility binding that is not merely a transient local ordinal.

When a reviewable case offers acceptance of a synthesized or provisional
default, implementations SHOULD expose that proposed value as structured data
rather than only as prose. A host that resumes or renders review state should
not need to parse a human-oriented message string to know what is being
accepted.

When a reviewable case allows a caller to provide a structured replacement
value, that decision payload SHOULD travel through the same replay-safe review
surface rather than requiring a separate out-of-band override channel.

If an imported review decision requires structured payload data, a consumer
SHOULD validate that payload before applying it. Missing or semantically
mismatched payload MUST NOT be silently treated as a valid resolution.

When review requests expose multiple possible actions, implementations SHOULD
export those actions as structured offers rather than as a bare string list, so
hosts can determine whether additional payload is required before presenting or
submitting a decision.

If a review action requires structured payload, the action offer SHOULD identify
the payload kind explicitly rather than requiring the host to infer it from the
action name alone.

When a consumer rejects one specific replayed review decision, it SHOULD expose
the rejected request identity and action in structured diagnostic fields rather
than only in diagnostic prose.

When a rejected or invalid review decision falls into a known machine-readable
class, a consumer SHOULD also expose a structured diagnostic reason rather than
forcing hosts to infer that reason from human-readable prose.

If the rejection or invalidity is specifically due to missing structured review
payload, the consumer SHOULD expose the required payload kind on the diagnostic
itself rather than only in the review action offer.

If the rejection or invalidity is specifically due to a family mismatch, the
consumer SHOULD expose the expected and provided family identities on the
diagnostic itself rather than only in prose.

When diagnostics carry review-specific structured metadata, implementations
SHOULD prefer a nested review-detail object rather than continuing to grow the
top-level diagnostic surface with review-only fields.

### 5.17 Review Identity

An opaque stable identifier for a resolution case that is intended to remain meaningful across recomputation of the same unresolved merge surface.

A review identity is a semantic binding concept, not a prescribed encoding. It is used to determine whether a saved review decision still refers to the same reviewable case after the merge state is recomputed.

A review identity is distinct from a runtime-local case number, presentation order, or storage offset. Those MAY be useful within one producing runtime but are not, by themselves, replay-safe semantic identifiers.

### 5.18 Replay Compatibility Context

The minimum externally visible context needed to evaluate whether previously saved unresolved-review decisions still apply to a newly produced unresolved state.

Replay compatibility context MAY include source-version evidence, ruleset-version evidence, normalized input fingerprints, or other compatibility indicators. This document does not standardize the transport shape or exact fields. It standardizes only the concept that replay-safe review requires explicit compatibility evaluation rather than blind reassociation by local case identifier.

When a consumer exposes resumable review state, it MAY also expose host-policy
hints describing whether the producing call was interactive-capable, whether
strict explicit declarations were required, or similar caller-selected review
constraints. Such hints are descriptive state, not transport or UI commands.

If a consumer accepts imported review decisions for replay, those decisions
SHOULD be accompanied by replay-compatibility context. A consumer that cannot
establish compatibility SHOULD reject the imported decisions explicitly rather
than downgrading silently to best-effort positional reassociation.

When compatibility is established, a consumer SHOULD still evaluate whether each
imported decision refers to a currently live review identity rather than
assuming that every decision in a compatible bundle remains applicable.

Implementations MAY expose replay inputs as separate fields or as one replay
bundle object so long as the observable replay-compatibility and replay-safety
semantics remain unchanged.

If review state or replay bundles are externalized as JSON, implementations
SHOULD preserve the normalized observable contract across serialization and
deserialization rather than treating JSON export as an implementation-private
debug dump.

When implementations externalize review state or replay bundles for transport,
they SHOULD prefer an explicit kind-marked, versioned envelope over a bare
payload with only out-of-band meaning. A consumer that receives an unexpected
envelope kind or unsupported envelope version SHOULD reject that transport
explicitly rather than treating it as best-effort compatible.

### 5.19 Diagnostic Surface

The externally visible reporting channel through which a consumer exposes unsupported capabilities, repair-policy activation, delegation failure, unresolved-outcome activation, or other declared-contract mismatches.

A diagnostic surface is a consumer-facing reporting concept. It is not, by itself, a separate ruleset directive or semantic axis unless some future extension explicitly declares one.

## 6. Capability Classes

Capability classes describe which semantic surfaces, support boundaries, or declared limitations are part of the merge contract.

These classes are not limited to comments. They cover:

- whether the format is purely structural or also layout-aware,
- whether non-structural content such as comments participates in merge behavior,
- whether logical preservation rules exist beyond ordinary structural ownership,
- whether output is governed by a portable write contract or native parser mutation.

A ruleset consumer **MUST** recognize the capability vocabulary defined in this section and treat it as part of the declared contract vocabulary.

These capability classes describe the externally relevant merge contract. They do **not** standardize:

- parser APIs,
- internal syntax models,
- attachment data structures,
- wrapper layers,
- adapter boundaries,
- internal call graphs.

Not every ruleset will require every class. For example, a comment-free format such as strict JSON may rely on structural and layout declarations while never requiring comment-fidelity capabilities.

This document therefore includes comment-free formats within scope. The compact ruleset shape defined here still uses a uniform declaration model centered on `read` and `attach`, but that does not imply every ruleset depends on rich comment semantics.

In this model:

- the `read` directive selects among the read/write realization classes in Sections 6.3 through 6.5, and
- the `capability` directive may declare additional semantic surfaces or explicit support boundaries relevant to the ruleset contract.

### 6.1 `structural_only`

The merge contract is defined entirely in terms of structural owners, match keys, and rendering behavior.

No comment surface is required by the ruleset.

This class is appropriate for formats or usage profiles where merge semantics are fully captured by structural ownership and value shaping alone.

### 6.2 `layout_aware`

Blank-line gaps or similar non-token layout regions may carry ownership or preservation meaning.

This class is independent of comment support. A format MAY be layout-aware even if it has no comment syntax.

### 6.3 `source_augmented_portable_write`

Comments or other non-structural annotations are discovered from source text or auxiliary tracking, while output is emitted through a portable write layer.

This class is appropriate when the parser does not expose a sufficiently editable native comment model, but the merge contract still requires preservation of non-structural content.

### 6.4 `native_read_portable_write`

Comments or other non-structural annotations are read from parser-native structures or parser-provided attachment hints, while output is still emitted through a portable write layer.

This class is appropriate when native read fidelity exists, but implementation portability or merge-contract stability still depends on a ruleset-governed write layer.

### 6.5 `native_mutation`

Comments or other non-structural annotations are both read and emitted through native parser-owned structures.

This class is appropriate when the parser provides sufficiently complete mutation support for the merge contract to be satisfied without an intermediate portable write layer.

### 6.6 `logical_owner`

The format contains merge-relevant artifacts whose preservation is determined by logical reference or semantic linkage rather than ordinary structural containment.

This class signals that pure structural presence is insufficient to describe full merge behavior.

In the standard vocabulary of this draft, declaration of one or more `logical_owner` directives is sufficient to establish that logical-owner semantics are part of the ruleset contract.

A bare `capability logical_owner true` declaration MAY advertise that such semantics exist, but it does not by itself declare any concrete logical-owner class or preservation policy.

This capability class indicates that logical-owner semantics are part of the ruleset contract. It does not by itself identify which logical-owner classes exist or what preservation policy each class requires.

## 7. Ruleset Model

A merge ruleset always describes the following core axes:

- owner selector,
- match key,
- read strategy,
- attachment strategy.

A merge ruleset MAY additionally declare optional axes when they are part of the merge contract:

- comment style,
- render family,
- capability declarations,
- logical-owner declarations,
- repair-policy declarations,
- merge-surface declarations and delegation policies.

A richer ruleset model MAY additionally describe:

- derived feature-profile metadata,
- derived conformance or reporting expectations for unsupported or partially supported behavior.

### 7.1 Shared Baseline Owner Selector

A shared baseline owner selector pattern is:

> all line-bound structural statements with stable start and end locations

This baseline is suitable for many structured line-oriented formats and is commonly the explicit `owners` declaration in such rulesets.

### 7.2 Explicit Owner Selectors

A ruleset SHOULD declare a more specific owner selector when the shared baseline is insufficient, including cases such as:

- assignment lines plus freeze blocks,
- root pairs before a table boundary,
- mapping entries only,
- syntax-family-specific block constructs,
- logical artifacts preserved by reference.

### 7.3 Attachment Strategy Vocabulary

The following attachment strategies are defined:

- `layout_only`
- `tracker_layout_merge`
- `augmenter_preferred_tracker_layout`
- `normalize_tracked_layout_merge`

These names define behavioral classes, not implementation language APIs.

### 7.4 Derived Feature Profile

A producer or consumer MAY derive a feature profile from the ruleset for inspection, diagnostics, conformance reporting, or other specification-facing reporting.

When a feature profile is exposed, it SHOULD summarize the declared behavior without inventing undeclared semantics.

In particular, omission of optional directives remains meaningful. A derived feature profile SHOULD distinguish between an undeclared surface and a declared surface whose value is known.

### 7.5 Repair Policies

Some formats or implementations repeatedly encounter ambiguous states that are neither pure parser failure nor ordinary declarative merge behavior. Examples include:

- duplicate ownership of the same comment region,
- overlapping attachment regions,
- previously produced states that do not fit the ideal ownership model,
- partially supported states that require declared handling rather than silent reinterpretation.

A ruleset MAY declare one or more repair policies for such states so that consumers do not silently convert one behavior class into another.

### 7.6 Merge Surfaces and Delegation

A ruleset MAY declare one or more merge surfaces for embedded or nested content.

If delegation policy is declared for such content, it applies to a named declared merge surface rather than creating a surface implicitly.

If no `delegate` directive is declared for a given surface, the ruleset has not declared a distinct delegation policy for that surface. Consumers MUST NOT infer one implicitly from mere surface declaration alone.

Examples include:

- fenced code blocks whose inner language is determined by a tag,
- documentation blocks with their own merge semantics,
- embedded JSON, YAML, or shell fragments nested inside a host format.

The declaration of merge surfaces or delegation policies does not require a single universal runtime architecture. It only requires that a conforming consumer preserve the declared surface boundaries and delegation semantics at the observable behavior level.

## 8. Ruleset Syntax

A merge ruleset is a compact line-oriented declaration document.

Each non-empty non-comment line contains one directive.
Directives are space-separated tokens.
Comment lines begin with `#`.

The minimal grammar is defined in [Appendix A](#appendix-a-minimal-ruleset-grammar).

### 8.1 Required Directives

A conforming ruleset MUST declare:

- `format`
- `owners`
- `match`
- `read`
- `attach`

This draft intentionally keeps those directives mandatory even when a ruleset is primarily structural or layout-oriented. In such cases, the declared `read` and `attach` values define the normalized contract shape even if comment participation is absent or operationally minimal.

### 8.2 Optional Directives

A conforming ruleset MAY additionally declare:

- `comment_style`
- `render`
- `capability`
- `logical_owner`
- `repair`
- `surface`
- `delegate`
- namespaced extension directives

### 8.3 Unknown Directives and Values

A ruleset consumer:

- **MUST** reject unknown required directives,
- **MAY** ignore unknown optional extension directives or values if they are explicitly namespaced or otherwise marked non-critical,
- **MUST** reject unknown values for declared standard directives whose vocabularies are defined by this specification unless an extension mechanism explicitly permits them (in this draft, see the closed vocabularies defined for `read` and `attach` in Section 9).

### 8.4 Directive Order

For the standard directives defined in this document, directive order is not itself semantically significant.

Repeated standard directives such as `capability`, `logical_owner`, `repair`, `surface`, and `delegate` are cumulative declarations in this draft. Their relative order does not define precedence unless some future extension explicitly introduces an order-sensitive rule.

Within those repeatable directive families, the identifying key for each declaration is expected to be unique in this draft:

- `capability` by capability name,
- `logical_owner` by logical-owner class,
- `repair` by named state class,
- `surface` by surface name,
- `delegate` by referenced surface name.

Repeating the same identifying key with multiple standard declarations is malformed unless some future extension explicitly permits it.

By contrast, `format`, `owners`, `match`, `read`, `attach`, `comment_style`, and `render` are singleton declarations in this draft. Repeating any of those directives is malformed unless some future extension explicitly permits repetition.

Namespaced extension directives or values MAY define their own order, repetition, or precedence rules. Such extension-specific rules are outside the standard directive model defined here unless explicitly incorporated by a future specification.

## 9. Ruleset Semantics

This section defines closed standard vocabularies for `read` and `attach`.

Other directives in this section may use standard names illustrated here, but unless a subsection explicitly declares a closed vocabulary, their values remain profile-specific or extension-permitted in this draft.

### 9.1 `format`

Identifies the document family for human and machine-readable reference.

### 9.2 `owners`

Declares the owner selector. The consumer MUST interpret this as a behavior declaration, not as executable code.

### 9.3 `match`

Declares the match key strategy used to identify corresponding owners.

### 9.4 `read`

Declares the comment read/write capability class. Valid initial values are:

- `source_augmented_portable_write`
- `native_read_portable_write`
- `native_mutation`

The `read` directive declares an observable behavior class, not a required internal architecture.

For example:

- `source_augmented_portable_write` means comment or annotation fidelity originates from source scanning, auxiliary tracking, or equivalent non-native discovery while output remains governed by a portable write contract;
- `native_read_portable_write` means native parser fidelity contributes to annotation discovery while output remains governed by a portable write contract;
- `native_mutation` means native syntax-owned structures govern both read and write realization.

How a consumer internally realizes these classes is out of scope provided the declared behavior is preserved.

For a structurally dominant or comment-free ruleset, the selected `read` class may have little or no operational effect on observable merge behavior. It remains part of the normalized ruleset contract surface defined by this compact syntax.

### 9.5 `attach`

Declares the attachment strategy. Valid initial values are:

- `layout_only`
- `tracker_layout_merge`
- `augmenter_preferred_tracker_layout`
- `normalize_tracked_layout_merge`

These strategy names define observable attachment classes, not implementation APIs or object models.

At a minimum, a conforming consumer SHOULD preserve the following distinctions:

- whether only shared layout ownership is considered (`layout_only`);
- whether tracked comment attachment data participates directly in attachment (`tracker_layout_merge`);
- whether an augmented or synthesized attachment view is preferred before layout ownership is folded in (`augmenter_preferred_tracker_layout`);
- whether tracked attachment results are normalized to explicit layout-owned regions before final attachment is exposed (`normalize_tracked_layout_merge`).

The exact internal representation of tracked regions, augmenters, or attachment records is out of scope.

For a structurally dominant ruleset, the selected attachment strategy MAY be operationally trivial. It remains declaratively relevant because it states how non-structural ownership would be handled if such content participates in the merge contract.

### 9.6 `comment_style`

Declares the surface comment family, such as:

- `hash_comment`
- `c_style_line`
- `html_comment`

These names are illustrative in this draft unless a later profile or specification defines a closed comment-style vocabulary.

This directive MAY be omitted when comments are not part of the declared merge behavior.

### 9.7 `render`

Declares the render family relevant to the owner surface.

The render family identifies the normalized output-shaping contract associated with the ruleset. It does not require a specific emitter API, serializer object model, or source-shaping pipeline.

Render-family names remain profile-specific in this draft unless a later profile or specification defines a closed vocabulary.

### 9.8 `capability`

Declares a named capability statement relevant to the ruleset contract.

One or more `capability` directives MAY be declared when the ruleset needs to express multiple semantic surfaces, support boundaries, limitations, or non-support cases.

Depending on the vocabulary in use, a capability declaration may:

- advertise an additional semantic surface,
- declare a support boundary,
- record intentional non-support, or
- record a named divergence or limitation.

Capability declarations complement the rest of the ruleset. They need not redundantly restate semantics that are already fully declared by other directives such as `read`, `logical_owner`, `surface`, or `delegate`.

If a standard capability declaration redundantly restates semantics already established by other standard directives, it MUST remain consistent with those directives. Contradictory redundant standard declarations are malformed in this draft.

Within the standard vocabulary of this draft, each capability name is declared at most once.

Examples include:

- `capability structural_only true`
- `capability layout_aware true`
- `capability inline_comments false`
- `capability quoted_hash_inline_literals not_applicable`

### 9.9 `logical_owner`

Declares preservation policy for a logical-owner class.

Where the capability class `logical_owner` signals that such semantics exist, one or more `logical_owner` directives MAY identify concrete logical-owner classes and their declared policies.

Declaring one or more `logical_owner` directives is itself sufficient to establish that `logical_owner` semantics are present. A redundant `capability logical_owner true` declaration is not required by this draft.

If a bare `capability logical_owner true` declaration is used, it advertises logical-owner semantics without replacing the need for `logical_owner` directives when concrete classes or policies must be declared.

Within the standard vocabulary of this draft, each logical-owner class is declared at most once.

Logical-owner class names and preservation-policy names are profile-specific in this draft unless a later profile or specification closes that vocabulary.

Examples include:

- `logical_owner link_definition preserve_if_referenced`
- `logical_owner reference_target preserve_always`

### 9.10 `repair`

Declares handling for a named ambiguous, overlapping, or corruption-class state.

One or more `repair` directives MAY be declared when distinct state classes require distinct policies.

Within the standard vocabulary of this draft, each named state class is declared at most once.

Named state classes and repair-policy values are profile-specific in this draft unless a later profile or specification closes that vocabulary.

Initial values are intentionally policy-shaped rather than algorithm-shaped. Typical values include:

- `heal`
- `warn`
- `error`
- `skip`

A consumer **MUST NOT** silently apply undeclared repair behavior when the ruleset explicitly asks for a stricter policy.

When a declared repair policy or behavior profile allows recovery, the consumer
SHOULD expose that activation through an observable diagnostic surface rather
than making the widened acceptance path indistinguishable from baseline success.

When recovery is declared for a specific state class, consumers SHOULD preserve
the original failure behavior for out-of-scope states rather than opportunistically
reusing the same repair mechanism more broadly.

Consumers SHOULD also treat array resolution policy as a distinct merge surface
from object-member resolution, even when an initial profile chooses a very
simple baseline such as destination-wins replacement.

When multiple behavior-policy dimensions are exposed, consumers SHOULD identify
them through an explicit policy surface plus named policy reference rather than
embedding policy identity only in format-specific prose.

When a parse or merge result exposes active policy information, the consumer
SHOULD report it as structured policy references rather than collapsing it into
diagnostic text.

When an adapter or backend exposes policy support, the consumer SHOULD keep that
capability metadata distinct from result-level active policy reporting.

When adapter capability metadata is exposed through a normalized feature
profile, that profile SHOULD summarize capability surfaces without pretending to
be runtime result state.

When a document-family package exposes a feature profile above a specific
adapter, that higher-level profile SHOULD describe family behavior without
requiring backend identity to be the primary reporting surface.

That family-level reporting pattern SHOULD be expressible through a shared core
shape rather than remaining specific to one merge family.

As the shared fixture corpus expands, producers and consumers MAY rely on a
small conformance manifest to identify stable portable fixture subsets without
forcing each implementation to maintain its own divergent fixture index.

When backend identity is reported, consumers SHOULD prefer a normalized backend
reference over implementation-local naming alone so future backend selection and
conformance reporting do not collapse into package-specific strings.

When a shared fixture corpus is used across implementations, consumers MAY also
rely on stable conformance roles in a manifest so representative fixture
selection remains portable even as the corpus grows.

When a conformance manifest is exposed across implementations, consumers SHOULD
prefer a normalized family-indexed manifest shape over family-specific top-level
manifest fields so fixture discovery stays portable as more families are added.

When case-level conformance reporting is exposed, consumers MAY also derive or
report a normalized suite summary so aggregate status remains portable without
replacing case-level evidence.

When capability-aware conformance selection is exposed, consumers SHOULD report
selection explicitly rather than silently omitting unsupported cases. A skipped
case remains observable conformance evidence when the skip is derived from
declared dialect or policy support boundaries.

When reusable conformance runner helpers are exposed, consumers SHOULD preserve
ordinary case-result reporting for skipped cases rather than introducing a
separate hidden skip channel. Suite-level execution MAY be layered above such a
case runner so long as ordered case results remain observable and compatible
with normalized suite-summary derivation.

This draft does not define a standard `unresolved` directive or a standard persistence format for reviewable unresolved outcomes. Consumers MAY expose such runtime outcomes so long as they do not present them as additional declared ruleset directives unless a later profile or specification standardizes them.

When a consumer does expose a reviewable unresolved runtime outcome, it MAY report that operation as unresolved rather than completed even if a provisional emitted result is also available for inspection.

### 9.11 `surface`

Declares a named merge surface that may be selected or discovered within the host document.

One or more `surface` directives MAY be declared when the host format contains multiple merge-relevant embedded or nested regions.

Within the standard vocabulary of this draft, each surface name is declared at most once.

Surface names and selectors are profile-specific in this draft unless a later profile or specification closes that vocabulary.

Examples include:

- `surface fenced_code_block language_tag`
- `surface doc_comment fixed_kind`

### 9.12 `delegate`

Declares the delegation policy for a named merge surface.

One or more `delegate` directives MAY be declared when multiple declared merge surfaces require distinct delegation policies.

A `delegate` directive refers to a declared `surface` by name. It does not implicitly declare a merge surface on its own.

Absence of a `delegate` directive for a declared surface does not imply an undeclared default policy in this draft; it only means that no distinct delegation policy has been declared for that surface.

Delegation-policy names are profile-specific in this draft unless a later profile or specification closes that vocabulary.

Within the standard vocabulary of this draft, each declared surface has at most one delegation policy declaration.

Examples include:

- `delegate fenced_code_block by_language`
- `delegate doc_comment same_ruleset`

This directive describes observable delegation intent. It does not require any specific implementation mechanism.

## 10. Normative Example

The following ruleset is a normative example of a valid compact merge ruleset:

```text
format toml
owners line_bound_statements
match signature
read native_read_portable_write
attach normalize_tracked_layout_merge
comment_style hash_comment
render toml_pairs_and_tables
```

A conforming ruleset consumer:

1. **MUST** parse this ruleset successfully.
2. **MUST** recognize `format`, `owners`, `match`, `read`, and `attach` as required directives, and **MUST** correctly interpret the declared optional directives `comment_style` and `render` when present.
3. **MUST** interpret `read native_read_portable_write` as a declaration that comment read fidelity originates from native parser support or parser-provided attachment hints while output is governed by a portable write contract.
4. **MUST** interpret `attach normalize_tracked_layout_merge` as a declaration that tracked attachment data is merged with shared layout ownership and normalized where layout-owned leading regions need explicit surfacing.
5. **MAY** use implementation-specific internal representations so long as the observable declared behavior remains equivalent.

## 11. Additional Informative Examples

### 11.1 Dotenv-Like Format

```text
format dotenv
owners assignment_lines_plus_freeze_blocks
match env_key
read source_augmented_portable_write
attach tracker_layout_merge
comment_style hash_comment
render dotenv_assignments
capability template_only_comments false
```

### 11.2 JSON-with-Comments-Like Format

```text
format jsonc
owners line_bound_statements
match signature
read source_augmented_portable_write
attach augmenter_preferred_tracker_layout
comment_style c_style_line
render json_object_pairs
capability quoted_hash_inline_literals not_applicable
```

### 11.3 Markdown Link Definitions

```text
format markdown
owners link_definitions
match normalized_reference
read source_augmented_portable_write
attach tracker_layout_merge
comment_style html_comment
render markdown_link_definitions
logical_owner link_definition preserve_if_referenced
capability remove_template_missing_nodes false
capability inline_comments false
surface fenced_code_block language_tag
delegate fenced_code_block by_language
surface doc_comment fixed_kind
delegate doc_comment same_ruleset
repair comment_ownership_overlap warn
```

## 12. Conformance Requirements

A conforming ruleset consumer:

1. **MUST** parse the grammar defined in Appendix A.
2. **MUST** preserve directive order only where the local ruleset model declares order significance.
3. **MUST** reject malformed required directives.
4. **MUST** reject malformed declared optional directives when they are present.
5. **MUST** reject repeated singleton standard directives unless an extension mechanism explicitly permits repetition.
6. **MUST** reject repeated standard declarations within a repeatable directive family when they use the same identifying key unless an extension mechanism explicitly permits such duplication.
7. **MUST** reject contradictory redundant standard capability declarations when equivalent semantics are already established by other standard directives.
8. **MUST** reject unknown values for required standard directives whose vocabularies are defined by this specification unless an extension mechanism explicitly permits them.
9. **MUST** reject unknown values for declared optional standard directives whose vocabularies are defined by this specification unless an extension mechanism explicitly permits them.
10. **MUST NOT** silently reinterpret one declared strategy as another.
11. **MUST** correctly interpret declared optional directives according to their specified contract semantics when they are present.
12. **MUST** reject a declared `delegate` directive that refers to an undeclared `surface` unless an extension mechanism explicitly permits such indirection.
13. **MUST NOT** infer an undeclared delegation policy solely from the presence of a declared `surface`.
14. **SHOULD** expose unsupported declared capabilities as explicit diagnostics.
15. **SHOULD** treat owner selectors as declarative contracts rather than arbitrary embedded code.
16. **SHOULD** expose declared repair-policy activation through an observable diagnostic surface when the selected policy is not silent success.
17. **SHOULD** preserve declared merge-surface and delegation boundaries even if the implementation realizes them through local composition or delegation mechanisms.
18. **MAY** expose a derived feature profile for inspection, diagnostics, conformance reporting, or other specification-facing reporting.
19. Diagnostics and reporting surfaces **SHOULD** reflect declared ruleset meaning and conformance state rather than introduce additional undeclared semantics.
20. If a derived feature profile is exposed, it **SHOULD** reflect normalized ruleset meaning rather than implementation-local realization detail.
21. **MAY** extend the vocabulary with namespaced directives or values.
22. If a consumer externalizes unresolved review state for later replay, it **SHOULD** preserve enough review identity and replay compatibility context to reject stale or misbound selections rather than relying solely on runtime-local case identifiers.
23. A consumer that replays previously externalized unresolved review state **MUST NOT** silently reattach a saved selection to a different current case when compatibility cannot be established.

## 13. Implementation and Adoption Considerations

Early adoption is improved if the ecosystem develops:

- one or more early conforming implementations,
- a language-neutral conformance fixture corpus,
- manifest-driven suite planning and reporting surfaces,
- additional independent implementations,
- examples spanning multiple document families,
- reusable feature-profile and diagnostic tooling,
- merge-surface and delegation fixtures for embedded-language cases,
- replay/resume fixtures for unresolved review handoff across process or tool boundaries.

The ruleset model is likely to stabilize faster if:

- early parsers and validators are exercised against real rulesets and shared fixtures from the start,
- the conformance corpus is separated from any one implementation once reuse appears,
- draft text remains independent of any single code library.

An adoption strategy that combines early conforming implementations with shared fixtures is therefore RECOMMENDED as a practical path toward broader interoperability evidence.

## 14. Interoperability Considerations

This document aims at semantic interoperability, not byte-identical output.

Two implementations can both conform while differing in:

- parser library,
- syntax representation,
- internal attachment data structures,
- serialization internals.

However, interoperability improves when implementations consuming the same ruleset agree on:

- owner-selector meaning,
- match-key meaning,
- comment-style and non-structural ownership semantics,
- attachment-strategy meaning,
- render-family meaning,
- logical-owner preservation rules,
- declared limitations and support boundaries,
- repair-policy handling,
- merge-surface boundaries and delegation policies,
- and, when unresolved review state is externalized, review-identity meaning and replay-compatibility expectations.

Interoperability does not require shared internal representations for:

- internal syntax objects,
- attachment state records,
- gap-tracking mechanisms,
- rendering stages,
- delegation topology.

Those remain implementation detail so long as normalized ruleset meaning is preserved at the observable behavior level.

When unresolved review state is exchanged between tools or processes, raw local case identifiers alone are not sufficient for interoperability. Interoperability in that scenario depends on whether implementations agree about the semantic identity of a reviewable case and about what constitutes a compatible replay context.

## 15. Security Considerations

Merge rulesets affect how configuration, source, or content documents are reconciled. An incorrect or malicious ruleset can:

- preserve content that should be removed,
- remove content that should remain,
- alter comment or gap ownership in misleading ways,
- change the meaning of configuration files after merge,
- or cause a stale external review decision to be applied to the wrong current unresolved case.

Implementations SHOULD:

- validate ruleset syntax,
- validate required directive values,
- fail loudly on unknown critical terms,
- avoid silent fallback that changes merge semantics,
- expose capability mismatches through explicit diagnostics,
- expose repair-policy activation and delegation failure through explicit diagnostics when the declared policy requires visibility,
- treat externalized unresolved review state as untrusted input,
- reject replay when review identity or replay compatibility context no longer matches the current unresolved surface,
- avoid positional or ordinal-only replay of saved review decisions across processes or tools.

## 16. IANA Considerations

This document has no IANA actions.

## 17. Relationship to Existing Standards

Existing RFCs closest to this topic include:

- RFC 5789 (HTTP PATCH),
- RFC 6902 (JSON Patch),
- RFC 7396 (JSON Merge Patch),
- RFC 5261 (XML Patch Operations),
- RFC 8072 (YANG Patch),
- RFC 3284 (VCDIFF).

Those documents standardize change transport, patch documents, or differencing formats. They do not standardize:

- cross-language merge vocabulary,
- non-structural ownership classes,
- comment-style declarations,
- layout-gap semantics,
- render-family declarations,
- logical-owner preservation rules,
- repair-policy handling,
- merge-surface and delegation behavior,
- a compact declarative merge ruleset contract.

This document is therefore complementary to existing patch standards rather than competitive with them.

## 18. Rationale for Informational Status

At present, the strongest common result is a shared vocabulary and a declarative ruleset structure, not a universally proven merge algorithm.

Informational status is appropriate because:

- the conceptual model appears portable across multiple document families,
- algorithmic details remain syntax-sensitive,
- some behavior classes still depend on syntax-family-specific owner selection rules,
- broader interoperability evidence is needed before a standards-track algorithm would be justified.

If this model demonstrates adoption across independent implementations and document families, a future BCP or Standards-Track effort MAY become appropriate.

## Appendix A. Minimal Ruleset Grammar

The following ABNF describes the minimal compact ruleset syntax.

```abnf
ruleset        = *(blank-line / comment-line / directive-line)

blank-line     = *WSP line-end
comment-line   = *WSP "#" *not-line-end line-end
directive-line = *WSP directive *(1*WSP argument) *WSP line-end

directive      = identifier
argument       = identifier / boolean / token

identifier     = ALPHA *(ALPHA / DIGIT / "_" / "-" / ".")
boolean        = "true" / "false"
token          = 1*(%x21 / %x24-7E)

not-line-end   = %x00-09 / %x0B-0C / %x0E-7E / UTF8-non-ascii
line-end       = LF / CRLF
```

This grammar is intentionally minimal. A future specification MAY define:

- quoted strings,
- namespaced extension directives,
- structured capability values,
- grouped logical-owner declarations,
- grouped repair-policy declarations,
- grouped surface/delegation declarations.

## Appendix B. Conformance Matrix

| Feature | Producer MUST | Consumer MUST | Notes |
| --- | --- | --- | --- |
| Parse required directives | Yes | Yes | `format`, `owners`, `match`, `read`, `attach` |
| Reject unknown required directives | N/A | Yes | Unknown required directive names are hard failures |
| Treat standard directive order as non-semantic | No | Yes | Producers MAY emit any order; repeated standard directives are cumulative unless a future extension declares otherwise |
| Reject malformed required directives | N/A | Yes | Hard failure |
| Reject malformed declared optional directives | N/A | Yes | Optional to declare, not optional to validate once declared |
| Reject repeated singleton standard directives | N/A | Yes | `format`, `owners`, `match`, `read`, `attach`, `comment_style`, and `render` are singleton declarations in this draft |
| Reject duplicate identifying keys within repeatable standard directives | N/A | Yes | Applies to repeated `capability`, `logical_owner`, `repair`, `surface`, and `delegate` declarations using the same key |
| Reject contradictory redundant standard capability declarations | N/A | Yes | Redundant capability statements cannot contradict semantics already established by other standard directives |
| Reject unknown values for required standard directives with constrained vocabularies | N/A | Yes | In this draft, the closed required standard vocabularies are `read` and `attach`; no silent remapping |
| Reject unknown values for declared optional standard directives with constrained vocabularies unless extensions permit them | N/A | Yes | Applies where a later subsection or future specification defines a closed optional standard vocabulary |
| Do not silently reinterpret one declared strategy as another | N/A | Yes | Declared standard strategy values are not remapped to nearby alternatives |
| Support comments beginning with `#` | Yes | Yes | Ruleset-level comments, not merged document comments |
| Support namespaced extension directives or values | No | No | Optional |
| Preserve declarative meaning of owner selector | Yes | Yes | No executable-code dependency |
| Permit omission of optional directives when those surfaces are outside the declared contract | Yes | Yes | For example, `comment_style` or `render` may be absent when undeclared |
| Correctly interpret declared optional directives when present | No | Yes | Includes `comment_style`, `render`, `capability`, `logical_owner`, `repair`, `surface`, and `delegate` |
| Reject `delegate` references to undeclared surfaces | N/A | Yes | Delegation policy does not implicitly declare a merge surface |
| Do not infer undeclared delegation policy from a declared surface alone | N/A | Yes | Surface declaration and delegation declaration remain distinct |
| Surface unsupported capability declarations | N/A | Should | Diagnostic behavior |
| Honor declared repair-policy semantics | Yes | Yes | No silent remapping from `error` to healing |
| Surface visible repair-policy activation | N/A | Should | Warning/error/diagnostic behavior |
| Preserve declared merge-surface boundaries and delegation policies | Yes | Yes | Especially for embedded-language cases |
| Expose normalized feature profile meaning, if such a profile is exposed | N/A | Should | Derived reporting surface; preserve meaningful omission of undeclared optional directives |
| Guarantee byte-identical merged output | No | No | Out of scope |
| Guarantee semantic-equivalent declared behavior | Yes | Yes | Core intent |

## Authors' Note

The central claim of this document is that structured document merge is its own interoperability problem. It is not reducible to line diff, patch application, or plain tree replacement. The recurring portable concepts are:

- owner selection,
- identity matching,
- comment-style declarations,
- render family,
- read strategy,
- attachment strategy,
- capability declarations,
- layout ownership,
- logical-owner preservation rules,
- repair-policy handling,
- merge-surface and delegation behavior,
- diagnostic visibility for unsupported declared behavior.

Those concepts appear standardizable even where one universal merge algorithm does not.
