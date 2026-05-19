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

## Prior-art adoption backlog

This backlog tracks the pieces we should absorb from Weave, Mergiraf, and
related structured-merge work. The goal is not to clone any one architecture.
The goal is to combine the strongest prior art with StructuredMerge's own
ruleset, fixture, review, and multi-runtime model.

### Source-region model

- [ ] Define a portable source-region shape that can represent alternating:
  - structural owner regions, such as functions, classes, methods, impl blocks,
    object members, and module declarations;
  - interstitial regions, such as imports, leading comments, blank-line gaps,
    separators, and file headers/footers.
- [ ] Add fixture cases proving that source-region extraction preserves:
  - entity content;
  - leading/trailing comments attached to an owner;
  - blank-line ownership between sibling owners;
  - file-header and file-footer regions;
  - trailing newline state.
- [ ] Decide how source-region identity maps to existing terms:
  - logical owner;
  - merge surface;
  - child group;
  - blank-line region;
  - attachment.
- [ ] Add one source-family fixture where two branches add independent functions
  to the same textual area and the expected result is clean.
- [ ] Add one source-family fixture where two branches add independent methods
  inside the same class or impl block and the expected result is clean through a
  child-group merge.
- [ ] Add one source-family fixture where two branches touch the same owner body
  and the expected result delegates to an intra-owner merge rather than a global
  source-file conflict.

### Matching and identity

- [ ] Define a source-owner identity profile covering:
  - owner kind;
  - owner name;
  - parent/container scope;
  - backend-provided structural identity when available;
  - content-derived fallback identity when structural identity is ambiguous.
- [ ] Add duplicate-owner fixtures proving that repeated names are matched 1:1
  with ordered cursors or an equivalent stable pairing model.
- [ ] Add ambiguous-identity fixtures for:
  - anonymous closures or lambdas;
  - repeated trait/impl-like containers;
  - same-name methods in different visibility or namespace sections;
  - macro-generated or DSL-generated source owners.
- [ ] Define confidence levels for source-owner matching, such as exact,
  structural, content-hash, token-similar, and unresolved.
- [ ] Ensure match confidence is reported through the same diagnostic/reporting
  surface as other merge decisions.

### Rename and move detection

- [ ] Add a rename-detection policy profile that can use:
  - body hash with owner-name normalization;
  - structural hash;
  - token similarity;
  - parent/scope similarity;
  - backend-native move metadata when available.
- [ ] Add fixtures for clean rename-only changes.
- [ ] Add fixtures for rename-plus-edit conflicts when both sides rename or edit
  the same owner in incompatible ways.
- [ ] Add fixtures for moving a method between containers while preserving
  destination ordering policy.
- [ ] Keep rename/move detection as an explicit capability, not an implicit
  always-on behavior.

### Interstitial and layout merge

- [ ] Define interstitial-region merge rules separately from owner merge rules.
- [ ] Add fixtures for import/use/require ordering where both branches add
  imports in nearby positions.
- [ ] Add fixtures for comments between functions, including comments that are:
  - attached to the preceding owner;
  - attached to the following owner;
  - standalone interstitial content.
- [ ] Add fixtures for blank-line-only changes where the merge must preserve the
  declared owner of whitespace instead of normalizing globally.
- [ ] Add fixtures for file-header and file-footer edits.
- [ ] Decide when interstitial conflicts should be rendered as file-level
  conflicts versus scoped conflicts around nearby owners.

### Nested/container merge

- [ ] Promote container member merging to a source-family child-group profile.
- [ ] Add fixtures for:
  - TypeScript class methods;
  - Rust impl items;
  - Go methods/functions grouped by receiver or file section;
  - Ruby methods under visibility sections;
  - object/map-like source constructs where order may or may not matter.
- [ ] Declare which child groups are ordered, unordered, or policy-ordered.
- [ ] Require commutative child-group behavior to be declared by ruleset or
  family profile; do not infer commutativity from syntax alone.
- [ ] Add scoped-conflict fixtures where only one child member conflicts inside a
  larger clean container merge.

### Non-commutative construct safety

- [ ] Add negative fixtures for Python decorators proving that independent
  decorator additions are not automatically clean unless a rule declares safe
  ordering.
- [ ] Add negative fixtures for TypeScript/JavaScript decorators and annotations
  where order or stacking can affect behavior.
- [ ] Add fixtures for ordered middleware, callback, before/after hook, and macro
  stacks where syntactic adjacency is semantically meaningful.
- [ ] Define a rule vocabulary for declared commutativity, left-preferred order,
  right-preferred order, destination-order preservation, and conflict-on-order.
- [ ] Ensure unsafe unordered merges produce diagnostics that explain the specific
  order-sensitive construct.

### Fallback floor

- [ ] Define a cross-runtime fallback policy that is observable and reportable.
- [ ] Add fallback triggers for:
  - binary input;
  - unsupported parser or backend;
  - parser returns no structural owners for non-empty source;
  - both branches create a file from an empty base;
  - excessive duplicate identities;
  - timeout or resource budget exceeded;
  - backend diagnostics above the accepted severity threshold.
- [ ] Add a "never worse than baseline" comparison mode for merge drivers:
  compare structured output against the configured baseline merge and fall back
  when structured output produces more or broader conflicts.
- [ ] Define the baseline merge provider as a runtime integration point rather
  than hardcoding `git merge-file` into portable semantics.
- [ ] Add fixtures proving fallback activation is reported with reason, scope,
  selected baseline, and whether any structured result was discarded.
- [ ] Add negative fixtures proving fallback does not silently widen the merge
  semantics for cases outside its declared scope.

### Post-merge validation

- [ ] Define a post-merge validation phase that is separate from merge planning
  and rendering.
- [ ] Add validation checks for:
  - merged output reparses successfully when both inputs parsed successfully;
  - all cleanly resolved owners appear in output;
  - expected owner count does not drop unexpectedly;
  - unchanged significant lines are not lost;
  - branch-added significant lines are not lost;
  - output length is within policy-defined sanity bounds;
  - conflict-marker shape is compatible with the host VCS/tool.
- [ ] Make every validation failure produce either:
  - fallback to the configured baseline;
  - a scoped conflict;
  - a hard diagnostic failure.
- [ ] Add fixtures for silent-data-loss prevention.
- [ ] Add implementation hooks so validation can be strict in CI and more
  permissive in exploratory tooling only when explicitly configured.

### Conflict rendering and diagnostics

- [ ] Define a portable conflict-kind vocabulary for source merges:
  - both modified;
  - both added;
  - modify/delete;
  - rename/rename;
  - rename/modify;
  - order-sensitive sibling additions;
  - interstitial conflict;
  - validation failure.
- [ ] Add conflict complexity or risk metadata when a backend can classify the
  conflict as text-only, syntax-level, semantic-risk, or unknown.
- [ ] Support enhanced conflict metadata for humans while preserving standard
  conflict-marker compatibility for tools that require it.
- [ ] Add audit/report fields for:
  - owner identity;
  - owner kind;
  - strategy chosen;
  - match confidence;
  - fallback reason;
  - validation warnings;
  - conflict kind and scope.
- [ ] Ensure diagnostics are stable enough to be used by review-state and replay
  workflows.

### Formatter integration

- [ ] Treat formatters as optional post-merge adapters, not as proof of semantic
  correctness.
- [ ] Add a formatter policy vocabulary:
  - no formatter;
  - validate-only;
  - format-after-clean-merge;
  - format-after-fallback;
  - formatter failure is warning;
  - formatter failure is hard error.
- [ ] Add fixtures proving a formatter may repair whitespace without changing
  ownership, conflict scope, or validation semantics.
- [ ] Keep formatter execution outside portable fixture expectations unless the
  fixture explicitly opts into a formatter profile.

### Mergiraf/PCS lessons

- [ ] Preserve the option for finer AST-node merge profiles when owner-level merge
  is too coarse.
- [ ] Model PCS-like or successor-based child ordering as a possible backend
  strategy under a declared merge surface.
- [ ] Add fixtures where expression-level or argument-level structured merge is
  useful and owner-level fallback would be too blunt.
- [ ] Add fixtures where AST-level reconstruction would be risky because
  whitespace, comments, or conflict marker placement become ambiguous.
- [ ] Keep the public contract at the ruleset/fixture level so implementations
  can choose entity-level, AST-level, line-level, or hybrid algorithms.

### VCS and tool integration

- [ ] Define a merge-driver integration contract for Git.
- [ ] Define a merge-tool integration contract for Jujutsu.
- [ ] Support host-provided marker length and standard marker modes.
- [ ] Support optional enhanced markers when the host can tolerate them.
- [ ] Add audit artifact output for merge-driver runs.
- [ ] Add timeout/resource-budget configuration that cannot silently hang a VCS
  operation.
- [ ] Add clear diagnostics for skipped structured merge, fallback activation,
  and driver/tool invocation errors.

### Multi-runtime implementation plan

- [ ] Add source-region, fallback, validation, and conflict-report fixture roles
  to the source-family manifests.
- [ ] Implement the source-region model first in the runtime with the strongest
  parser support, then port through Go, Rust, TypeScript, and Ruby with the same
  fixtures.
- [ ] Keep backend-specific tree-sitter, native-parser, and AST-library behavior
  behind provider feature profiles.
- [ ] Add conformance gates that distinguish:
  - required portable behavior;
  - backend-restricted behavior;
  - experimental prior-art parity behavior;
  - runtime-local integration behavior.
- [ ] Add benchmark scenarios for false-conflict reduction without allowing
  benchmark wins to bypass fallback and validation requirements.

### Prior-art documentation

- [ ] Add a short source-family prior-art note summarizing what is adopted from
  Weave:
  - owner/interstitial region model;
  - explicit fallback floor;
  - post-merge validation;
  - confidence-scored matching;
  - scoped nested container merge.
- [ ] Add a short source-family prior-art note summarizing what is adopted from
  Mergiraf:
  - fine-grained AST matching as an optional profile;
  - successor/PCS-style child ordering as a backend strategy;
  - commutative parent handling only when declared;
  - rendering and conflict-marker compatibility concerns.
- [ ] Document explicit non-goals:
  - do not make entity-level merge the only architecture;
  - do not treat formatter output as semantic validation;
  - do not mark order-sensitive constructs clean by default;
  - do not hide fallback or validation failures.

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
