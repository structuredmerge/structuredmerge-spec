# Ast::Merge Spec-Alignment Todos

This document tracks the implementation work needed to make `ast-merge` look more like the emerging merge-ruleset specification while also preventing `ast-merge` from becoming an unbounded dumping ground.

The guiding principle is:

> Push shared behavior down into `ast-merge` when it is truly common, declarative, and spec-shaped. Push things out of `ast-merge` when they are runtime-specific, fixture-oriented, or only reusable once the interfaces have stabilized.

## Primary goals

1. Align internal terminology with the draft ruleset vocabulary.
2. Turn one-off merge-gem behavior into shared, ruleset-shaped behavior where possible.
3. Keep `ast-merge` usable as a reference implementation without making it even more monolithic.
4. Separate runtime substrate from conformance artifacts and implementation-specific extras when the seams become clear.

## Immediate wins

### Terminology alignment

- [x] Rename `source_augmented_synthetic` to `source_augmented_portable_write` in runtime code.
- [x] Rename `native_read_synthetic_write` to `native_read_portable_write` in runtime code.
- [x] Rename helper predicates to match:
  - `source_augmented_synthetic?` -> `source_augmented_portable_write?`
  - `native_read_synthetic_write?` -> `native_read_portable_write?`
  - `synthetic_write?` -> `portable_write?`
- [x] Update `Ast::Merge::Ruleset::Config::READ_STRATEGIES` to use the new names.
- [x] Update `Ast::Merge::Ruleset::Config#support_style` to use the new names.
- [x] Update `FileAnalyzable#comment_support_style` and `#shared_comment_support_style` to use the new names.
- [x] Update spec fixtures and harnesses to use the new terms.
- [x] Keep the word `synthetic` in targeted inline comments only where it explains the actual architecture, not the public contract.
- [ ] Decide how long to retain compatibility aliases for the old `synthetic` terminology in runtime code and ruleset parsing.

### Terminology separation

- [ ] Separate clearly in code and docs between:
  - parser capability
  - merge capability
  - support style / write model
  - ruleset capability declaration
- [ ] Audit whether `Comment::Capability` and `Comment::SupportStyle` names still match the spec direction, or whether one should be renamed to something closer to `ReadModel`, `WriteModel`, or `MergeRealization`.
- [ ] Add a concise glossary comment near the relevant classes so the codebase reflects the same distinctions as the draft.

## Shared behavior to push down into `ast-merge`

### Corruption-healing boundary

- [ ] Define a separate corruption-healing layer that sits above core merge semantics and can be switched or configured independently.
- [x] Introduce the first explicit healing policy seam in `prism-merge` for duplicate template-owned leading-prefix recovery, with `:heal`, `:warn`, `:error`, and `:skip` modes.
- [x] Propagate the initial corruption policy through recursive body merges and partial-template merge entry points so nested merges respect the same handling mode.
- [x] Extract the shared healing-policy contract into `ast-merge` as `Ast::Merge::Healer` so mode normalization and heal/warn/error/skip control flow are shared instead of reimplemented per merge gem.
- [x] Extract the repeated overlap-filter control flow into `Ast::Merge::Healer.filter_items` so downstream gems can share the same conditional-heal filtering contract instead of cloning it at each call site.
- [x] Gate removed-owner/orphan-rehoming overlap in `prism-merge` behind the same policy seam so comment-promotion cleanup does not silently define ownership semantics.
- [ ] Classify current duplicate-collapse, dedup, rehoming, and ownership-repair logic as either:
  - normative merge behavior
  - corruption recovery for historical outputs
  - ambiguous cases that need explicit policy names
- [x] Design a policy surface for suspected corruption handling, with modes such as:
  - `heal`
  - `warn`
  - `error`
  - `skip`
- [ ] Ensure the default shared runtime can operate without corruption healing for clean inputs and performance-sensitive callers.
- [ ] Add tests that prove the same input can be handled under different corruption policies without changing the core structural analysis contract.
- [ ] Make the no-generic-cleanup boundary explicit in shared behavior and specs: preserve owned oddities such as trailing spaces or whitespace-only lines unless a ruleset/format-specific merge policy explicitly defines a different equivalence or rendering rule.
- [x] Classify `prism-merge` postlude handling as analysis metadata rather than a live healing seam; current EOF/postlude preservation is structurally separate from the overlap-repair paths already gated.
- [x] Classify final blank-line normalization as a real output-repair pass rather than a conservative no-op safety net; instrumentation shows it mutates runtime outputs, even though the current suite still passes when it is disabled.
- [x] Remove the final blank-line normalization post-pass from `prism-merge` so spacing drift is no longer silently repaired after emission.
- [x] Tighten permissive spacing specs to assert exact preserved blank-line runs where preference and ownership already determine the intended output.
- [x] Fix destination-only sibling gap truncation in `prism-merge` so a node does not pre-emit one blank line from a repeated destination gap owned by the next sibling.
- [x] Add regression coverage that destination-owned whitespace-only lines are preserved across node gaps, comment-only gaps, and EOF/postlude output instead of being normalized away.
- [ ] Trace any remaining spacing drift back to leading-gap, trailing-gap, or orphan-gap ownership instead of reintroducing global cleanup.

### Ruleset-driven merge declarations

- [ ] Introduce a clearer mapping layer between ruleset directives and runtime behavior.
- [ ] Make the runtime treat `read`, `attach`, `capability`, and `logical_owner` as first-class declarative inputs rather than loosely related metadata.
- [ ] Add a single place where ruleset terms are translated into merge-facing runtime objects.
- [ ] Ensure the translation layer can support comment-free formats cleanly, not just comment-heavy formats.

### Shared owner-selection behavior

- [ ] Extract shared owner-selector helpers where the same owner-selection shapes recur across merge gems.
- [ ] Distinguish:
  - shared default owner selector behavior
  - explicit owner selector behavior
  - logical-owner selectors
- [ ] Reduce one-off owner-selection code in downstream gems where the behavior is really a named ruleset feature.

### Shared attachment behavior

- [ ] Audit downstream gems for one-off implementations of:
  - `layout_only`
  - `tracker_layout_merge`
  - `augmenter_preferred_tracker_layout`
  - `normalize_tracked_layout_merge`
- [ ] Move recurring attachment strategy orchestration fully into shared code where possible.
- [ ] Ensure attachment strategies can be selected by named behavior rather than per-gem method folklore.

### Shared layout behavior

- [ ] Expand the `Ast::Merge::Layout` namespace to cover more of the recurring blank-line ownership rules currently implemented ad hoc in leaf gems.
- [ ] Make layout-aware behavior explicit for formats that have layout meaning but no comment surface.
- [ ] Add shared tests for comment-free but layout-aware formats.
- [ ] Decide which whitespace equivalences, if any, belong to named layout policies (for example, treating whitespace-only lines as blank-line matches in some formats) instead of letting the generic engine silently normalize them.

### Shared logical-owner behavior

- [ ] Formalize logical-owner handling as a first-class shared substrate, not just a ruleset parser concept.
- [ ] Identify current downstream logical-owner-like cases and move their preservation/removal rules toward a common abstraction.
- [ ] Add shared runtime hooks for “preserve if referenced” and similar logical-owner policies.

### Shared renderer / source-shaper behavior

- [ ] Audit recurring emitter/source-shaping logic across merge gems.
- [ ] Determine what can become a shared renderer contract versus what remains format-specific.
- [ ] Align emitter terminology with the draft’s `render` directive language.

## Comment model follow-up

The shared comment language is already one of the strongest pieces of alignment work. The next step is to make it less like a shared convenience API and more like a reference implementation of the spec vocabulary.

- [ ] Review `Ast::Merge::Comment::{Capability, Region, Attachment, Augmenter, RegionMergePolicy}` against the current draft terminology.
- [ ] Decide whether any of these types should move out of the `Comment` namespace into a more general merge-model namespace.
- [ ] Ensure comment support is modeled as one axis of merge behavior, not the dominant axis.
- [ ] Add shared behavior for comment-free formats so the abstraction does not imply comments are always central.
- [ ] Document which comment abstractions are normative to the reference implementation and which are local implementation details.

## Runtime simplification targets

- [x] Identify runtime classes in `ast-merge` that are carrying both:
  - spec-facing declarative meaning, and
  - implementation-specific convenience logic
  and split those responsibilities where practical.

- [x] Audit whether `Ruleset::Config` should remain a single class or split into:
  - parser
  - validated model
  - runtime translator

- [x] Extract the first `Ruleset::Config` seams into dedicated classes:
  - `Ast::Merge::Ruleset::Parser`
  - `Ast::Merge::Ruleset::SupportStyleResolver`

- [ ] Decide whether the current `Config` class is now the long-term normalized model, or whether a distinct `Ruleset::Model` / `Ruleset::Definition` value object should replace it.

- [ ] Reduce bidirectional coupling between:
  - ruleset parsing
  - comment support style construction
  - file analysis helpers

- [x] Centralize support-style translation so `Ruleset::SupportStyleResolver` is the shared bridge for both ruleset parsing and file-analysis helper flows.

- [ ] Prefer named feature objects or policy objects over scattered booleans and symbols where the spec vocabulary is stabilizing.
- [x] Introduce an initial shared `Ruleset::FeatureProfile` value object and expose it through `FileAnalyzable`.

## Shared tests and conformance work

- [ ] Add shared examples that assert ruleset-term behavior, not just implementation-local method behavior.
- [x] Add shared example coverage for the initial feature-profile surface.
- [ ] Build conformance fixtures around:
  - owner selection
  - match keys
  - attachment strategies
  - logical-owner behavior
  - layout-aware behavior
  - comment-free formats
- [ ] Make at least one downstream merge gem prove each named feature through shared examples.
- [x] Make `prism-merge` expose and assert a concrete shared feature profile.
- [ ] Add terminology migration tests so old names are either rejected cleanly or supported temporarily through a compatibility layer.

## Things that may need to move out of `ast-merge`

These should not be extracted immediately unless the interface stabilizes, but they are good candidates to avoid future bloat.

### Conformance corpus

- [ ] Plan for a future `merge-ruleset-fixtures` or `merge-ruleset-tests` artifact once fixture reuse becomes language-neutral.

### Ruleset runtime

- [ ] Plan for a future `merge-ruleset` runtime gem once:
  - a second Ruby consumer exists, or
  - a non-Ruby implementation wants to share the same grammar/model.

### Draft / standards artifacts

- [ ] Keep draft text out of runtime packaging concerns.
- [ ] If the draft work grows, move it to a spec/docs-oriented home rather than keeping it coupled to gem packaging.

### Vendor- or app-specific recipe packs

- [ ] Do not let customer- or app-specific rule bundles accumulate in `ast-merge`.
- [ ] Keep private recipes, policy packs, and enterprise orchestration outside the reference implementation.

## Downstream gem audit backlog

- [ ] Audit each `*-merge` gem for behavior that should be replaced by named shared features.
- [ ] Build a matrix for each downstream gem covering:
  - owner selector
  - match key
  - attachment strategy
  - comment style
  - layout awareness
  - logical-owner behavior
  - render/source-shaper family
- [ ] Use that matrix to decide what belongs in:
  - shared substrate
  - per-format adapters
  - future conformance fixtures

## Suggested implementation order

1. Rename old `synthetic` read-strategy terms to `portable_write` terms.
2. Refactor `Comment::SupportStyle`, `Ruleset::Config`, and `FileAnalyzable` to use the new names.
3. Add shared tests covering the renamed vocabulary and compatibility behavior.
4. Define the corruption-healing boundary so recovery heuristics do not get mistaken for normative shared merge behavior.
5. Audit existing healing call sites and classify them by policy family.
6. Build a downstream feature matrix for the merge gems.
7. Extract the next shared behavior layer from that matrix:
   - owner selectors
   - attachment strategies
   - logical-owner policies
   - layout-aware behavior
8. Split `Ruleset::Config` internally if needed into parser/model/translator responsibilities.
9. Only then decide what should leave `ast-merge` as a separate runtime or fixture artifact.

## First concrete code targets

- `ast-merge/lib/ast/merge/comment/support_style.rb`
- `ast-merge/lib/ast/merge/ruleset/config.rb`
- `ast-merge/lib/ast/merge/file_analyzable.rb`
- `ast-merge/spec/ast/merge/ruleset/config_spec.rb`
- `ast-merge/spec/ast/merge/file_analyzable_spec.rb`
- `ast-merge/spec/support/fictive_language_harness.rb`

## Success criteria

- Public/spec-facing terminology in code matches the current draft.
- Shared behavior is selected by named feature or ruleset term more often than by one-off per-gem plumbing.
- Corruption recovery is explicit policy rather than an invisible default baked into core merge semantics.
- `ast-merge` becomes a clearer reference implementation of the draft rather than a growing pile of useful but disconnected merge utilities.
- Clear seams exist for future extraction of:
  - ruleset runtime
  - conformance fixtures
  - standards artifacts
