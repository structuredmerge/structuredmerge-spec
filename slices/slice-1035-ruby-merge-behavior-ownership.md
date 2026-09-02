# Slice 1035: Ruby Merge Behavior Ownership

## Status and scope

This slice inventories where merge behavior lives in the Ruby golden master at
revision `e3ad14c9a52bf12d24783104eddbf557db247d46`. It supplements the
base-class classification in Slice 841, the merge-gem authoring rules in Slice
839, and the downstream feature matrix in Slice 1006 with evidence from the
released implementation.

The inventory describes current ownership and flags boundaries that require
review. It does not promote duplicated behavior into a portable contract merely
because the duplication exists in released Ruby code.

## Ownership rule

Merge behavior has four implementation layers:

1. `tree_haver` owns backend registration, capability-aware parser selection,
   and the normalized parser facade. Merge packages do not select or invoke a
   parser outside this boundary.
2. `ast-merge` owns mechanics that apply across unrelated languages and
   formats: orchestration, matching primitives, comment and layout models,
   ownership selection, structural edits, source rendering, diagnostics,
   provider dispatch, and review/replay state.
3. A language or format substrate owns semantics shared by multiple parsers for
   that family, such as Ruby declaration identity, YAML mapping behavior,
   Markdown section behavior, or TOML dotted-key ownership.
4. A parser provider owns only the adapter needed to expose its concrete AST,
   source locations, parser capabilities, and extensions through TreeHaver and
   the family substrate. CLI, Git, CRISPR, and directory-template packages are
   adapters over these layers, not independent merge engines.

Behavior moves downward only as far as its semantics permit. A Ruby-specific
coverage directive belongs in `ruby-merge`; generic comment attachment belongs
in `ast-merge`; Prism node projection belongs in `prism-merge`.

## Shared ast-merge kernel

The released `ast-merge` source contains active shared mechanics in these
groups:

- merge orchestration and results: `SmartMergerBase`, `MergeResultBase`,
  `ConflictResolverBase`, `FileAnalyzable`, and `EmitterBase`;
- identity and matching: node/section typing, owner selection, match refiners,
  duplicate-aware mapping, and trailing-group alignment;
- source ownership and preservation: comment attachment and regions, layout
  gaps and policies, line ranges, source-region reports, and emitter line
  metadata;
- mutation and rendering: structural edit plans, source-render fragments and
  plans, partial-template helpers, and structured review application;
- execution contracts: provider registry/result validation, rulesets, runtime
  sessions, diagnostics, unresolved state, and replay support;
- reusable test support: provider conformance, comment/layout behavior, retained
  blank-gap compliance, and TreeHaver backend contracts under
  `Ast::Merge::RSpec`, loaded only by test harnesses.

Parser packages may specialize these mechanics, but should not fork them. A
parser-specific class deriving directly from an `ast-merge` base is not by
itself wrong; it becomes an ownership problem when it reproduces family
semantics already implemented by the family substrate.

## Family inventory

### Strong substrate delegation

- Markdown: `markdown-merge` owns section, nested-surface, wrapper, backend,
  source-preserving provider, and merge behavior. CommonMarker, Kramdown, and
  Markly providers depend on it and delegate through its classes and helpers.
- TOML: `toml-merge` owns dotted-key analysis, owner matching, source-preserving
  provider behavior, and merge orchestration. Citrus and Parslet providers
  depend on it, subclass its provider and smart merger, and select only their
  registered TreeHaver backend.
- Binary: `binary-merge` owns byte-preservation, unsafe diagnostics, and the
  provider contract. `zip-merge` depends on it and supplies the ZIP parser and
  archive-specific behavior.

### Substrate delegation with parser-specific implementation

- Ruby: `ruby-merge` owns the Tree-sitter/TSLP family path and shared Ruby
  semantics. `prism-merge` depends on it and reuses feature profiles, owner
  matching, signatures, gemspec behavior, documentation comments, scaffold
  chunks, rescue semantics, magic comments, coverage directives, and nocov
  wrappers. Prism still has parser-specific wrappers, analysis, emitters, and
  refiners, as expected for a richer native AST.
- YAML: `yaml-merge` owns the Tree-sitter/TSLP family path, normalized document
  analysis, mapping ownership, and generic merge behavior. `psych-merge`
  depends on it and delegates normalized document analysis and owner matching,
  but retains a parallel smart-merger, file-analysis, node-wrapper, emitter,
  merge-result, and conflict-resolver stack. The overlap is `review_required`:
  native AST handling may justify provider classes, while duplicated YAML merge
  policy does not.

### Single-package and direct families

- RBS intentionally hosts both the official `rbs` backend and the
  Tree-sitter/TSLP grammar in one package. Both parse through
  `TreeHaver.parser_for`; backend-specific AST projection remains internal.
- JSON, Bash, Go, Rust, TypeScript, and HTML currently expose direct
  Tree-sitter/TSLP-backed format packages without alternate parser-provider
  gems.
- Plain text and dotenv use synthetic line-oriented TreeHaver paths. Dotenv
  builds format ownership on the plain line substrate.

## Current review queue

The released implementation establishes these observations, not final
decisions:

- `psych-merge` has a valid dependency edge to `yaml-merge`, but its parallel
  merge stack needs a class-by-class ownership audit. Shared YAML semantics must
  move to `yaml-merge`; Psych-only AST projection and source capabilities stay
  in `psych-merge`.
- The runtime provider snapshot in Slice 1034 contains no generic Ruby workflow
  provider and no generic YAML workflow provider. Determine whether load paths,
  registration, or intended package roles account for each absence.
- The same snapshot advertises only the native RBS backend. Verify provider
  metadata against the two TreeHaver registrations without adding provider-side
  backend-selection logic.
- Parser-specific direct subclasses of `ast-merge` remain subject to semantic
  review. Inheritance shape alone cannot prove either correct sharing or drift.

## Migration effect

Ports start with the shared `ast-merge` mechanics, then the family substrate,
then provider adapters and extensions. They do not copy each released provider
stack independently. Where released Ruby packages duplicate a family semantic,
the Ruby implementation must first identify the authoritative substrate or
record an explicit provider-specific exception before the behavior is ported.

The machine-readable companion fixture records source anchors and review state
so later differential tests can replace static observations with executable
evidence.
