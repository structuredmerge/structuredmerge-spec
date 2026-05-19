# Ruby Prior-Art Convergence

This note classifies the Ruby implementation surface before the next
StructuredMerge convergence cycle. It treats `reference/` as read-only prior
art and the active Ruby gems under `structuredmerge/ruby/gems/` as the current
Ruby reference implementation candidate.

The key conclusion is:

- active Ruby `ast-merge` has absorbed the reference `ast-merge` file surface;
- active Ruby `tree_haver` intentionally diverges from the old reference
  `tree_haver` runtime wrappers and adds the current cross-runtime contract
  vocabulary;
- Go, Rust, and TypeScript should catch up to fixture-backed behavior, not to
  Ruby class names.

## Classification Labels

| Label | Meaning |
| --- | --- |
| Portable contract | Behavior that should be represented in shared specs/fixtures and implemented across runtimes. |
| Ruby reference helper | Ruby implementation machinery that may prove the behavior but should not become a portable API shape. |
| Ruby test convenience | RSpec or contributor support that is useful in Ruby but not a conformance mechanism for other runtimes. |
| Backend/provider-specific | Behavior that belongs to one parser/backend/provider and should be exposed through capability reports. |
| Historical compatibility | Surface retained to avoid breaking Ruby users or to ease migration from old packages. |
| Extraction candidate | Behavior likely to become its own package/artifact once a second implementation proves the contract. |

## Active `ast-merge` Surface

The active `structuredmerge/ruby/gems/ast-merge` file list matches the
read-only `reference/ast-merge` file list. That means the Ruby convergence task
is not primarily "port missing files"; it is classification and fixture
promotion.

| Surface | Classification | Convergence decision |
| --- | --- | --- |
| `SmartMergerBase` | Ruby reference helper | Keep as Ruby orchestration reference. Portable contract is parse -> analyze -> match -> resolve -> render -> validate, not the class name. |
| `ConflictResolverBase` | Ruby reference helper / portable strategy source | Keep node, batch, and boundary strategies as prior art. Promote strategy vocabulary into fixtures where behavior is shared. |
| `MergeResultBase` | Ruby reference helper / portable result source | Promote decisions, conflicts, unresolved cases, stats, and output metadata into portable result fixtures. Do not require line-array storage. |
| `FileAnalyzable` | Ruby reference helper | Promote parser diagnostics, freeze detection, feature profile, and comment/layout analysis behavior into fixtures. |
| `NodeWrapperBase`, `AstNode`, `NodeTyping` | Ruby reference helper | Promote normalized owner/signature/type behavior. Do not require wrapper inheritance outside Ruby. |
| `EmitterBase`, emitter provenance support | Ruby reference helper / portable rendering source | Promote rendering decisions, line metadata, provenance, and conflict-marker compatibility into fixtures. |
| `MatchRefinerBase`, `ContentMatchRefiner`, `TokenMatchRefiner`, `JaccardSimilarity` | Portable contract source | Promote match confidence and refinement outputs. Implementations may use different algorithms. |
| `DiffMapperBase`, `FileAlignerBase` | Ruby reference helper | Use as prior art for ordered matching and diff mapping. Promote only observable matching/alignment results. |
| `PartialTemplateMergerBase`, `KeyPathPartialTemplateMergerBase` | Extraction candidate | Keep Ruby implementation while fixture roles decide whether this is source-family behavior, template behavior, or structured-edit behavior. |
| `Comment::*` | Portable contract source | Promote comment regions, attachment, empty lines, tracker-layout merge, and comment style capability. Ruby classes remain implementation detail. |
| `Layout::*` | Portable contract source | Promote gap ownership, layout attachment, and layout augmentation. This is central to interstitial regions. |
| `FreezeNodeBase`, `Freezable`, `BlockDirective` | Portable contract source | Promote freeze/frozen-region behavior across families that support comments or block directives. |
| `Detector::*` | Portable contract source / backend-specific | Promote detected merge surfaces and delegated regions. Detector implementation remains runtime-specific. |
| `Runtime::*`, unresolved support/review state | Portable contract source / extraction candidate | Keep as the Ruby reference for review/replay, delegated children, sessions, and diagnostics. Promote JSON shape, not Ruby object shape. |
| `StructuralEdit::*` | Portable contract source / extraction candidate | Promote operation triad, boundaries, remove/rehome/splice plans, and replay receipts into shared fixtures. |
| `TrailingGroups::*` | Portable contract source | Promote destination-order and trailing group policies as explicit ordering fixtures. |
| `Ruleset::*` | Portable contract source / extraction candidate | Keep Ruby parser/model as reference while cross-runtime parsers prove the same compact ruleset fixtures. |
| `Recipe::*` | Ruby reference helper / possible future package | Keep out of core merge semantics unless fixture roles prove a portable recipe contract. |
| `RSpec::*` | Ruby test convenience | Do not port. Replace cross-runtime shared examples with fixture roles and conformance reports. |
| `Text::*` | Portable fallback source | Use as prior art for baseline text merge and intra-owner fallback, but expose via fallback policy fixtures. |

## Active `tree_haver` Surface

Active `tree_haver` differs from `reference/tree_haver` in the places we want:
the old direct runtime wrapper files are gone, and the new active surface has
contract/reporting and language-pack APIs.

Reference-only files:

- `backend_api.rb`
- `backends/ffi.rb`
- `backends/java.rb`
- `backends/mri.rb`
- `backends/rust.rb`
- `base.rb`
- `compat.rb`
- `language.rb`
- `node.rb`
- `parser.rb`
- `point.rb`
- `rspec.rb`
- `rspec/dependency_tags.rb`
- `rspec/testable_node.rb`
- `tree.rb`

Active-only files:

- `backend_context.rb`
- `contracts.rb`
- `kaitai_backend.rb`
- `language_pack.rb`
- `peg_backends.rb`

| Surface | Classification | Convergence decision |
| --- | --- | --- |
| `Base::Node`, `Base::Tree`, `Base::Parser`, `Base::Language`, `Base::Point`, `Base::Comment` | Portable parser/backend contract source | Promote required node/tree/span/source-fragment/comment behavior into tree-haver fixture roles. |
| `BackendRegistry`, `BackendContext` | Portable contract source with runtime-local mechanics | Promote backend references, registry identity, and temporary backend selection. Do not require Ruby thread-local implementation elsewhere. |
| `LanguageRegistry`, `LanguagePack` | Portable contract source | Promote language registration and language-pack process results through fixtures. |
| `contracts.rb` structs | Portable contract source | Treat as current Ruby reference for backend capability, normalized parse, provider diagnostics, edit projection, and availability reports. |
| `PathValidator`, `LibraryPathUtils` | Portable security policy source / runtime-specific implementation | Promote path/language/symbol/backend validation fixtures. Implementation can differ per language. |
| `GrammarFinder`, `CitrusGrammarFinder`, `ParsletGrammarFinder` | Backend/provider-specific | Keep Ruby-specific discovery helpers. Report behavior through backend/provider capability fixtures. |
| `Backends::Psych`, `Backends::Prism`, `Backends::Citrus`, `Backends::Parslet` | Backend/provider-specific | Keep as Ruby providers and use them to prove backend-restricted fixtures. |
| `KaitaiBackend`, `PegBackends` | Portable capability source / backend-specific | Promote capability vocabulary while keeping adapter code runtime-specific. |

## Reference Delta Decisions

| Delta | Decision |
| --- | --- |
| `ast-merge` active/reference file list has no delta | Treat active Ruby as the complete migrated prior-art surface. Focus on classification and fixture promotion. |
| Old tree-sitter runtime wrappers exist only in `reference/tree_haver` | Do not re-port wrappers by name. Reintroduce behavior only through backend references/capability fixtures if needed. |
| Old `TreeHaver::Node`, `TreeHaver::Tree`, `TreeHaver::Parser`, `TreeHaver::Point` top-level wrappers exist only in reference | Keep active `Base::*` contract shape. Add compatibility only if Ruby package consumers require it, not for portable conformance. |
| Active `tree_haver/contracts.rb` has no reference equivalent | Treat as the current cross-runtime contract seed. Align Go/Rust/TypeScript to its fixture-backed shapes. |
| Active `BackendContext` has no reference equivalent | Keep and promote temporary backend selection semantics through fixtures. Implementation mechanism remains runtime-local. |
| Active language-pack/Kaitai/PEG files have no reference equivalent | Treat as current structuredmerge innovations, not old Ruby prior art. |

## Portable Fixture Promotion Order

1. Tree-haver substrate fixtures:
   - backend reference and registry;
   - temporary backend selection;
   - node spans and source fragments;
   - parser diagnostics and error tolerance;
   - backend capability and availability;
   - comment capability when present.
2. Ast-merge core fixtures:
   - parse and merge result shape;
   - decision records;
   - diagnostics;
   - conflict records;
   - unresolved review cases;
   - fallback activation.
3. Source-family fixtures:
   - source regions;
   - interstitial regions;
   - owner matching;
   - child groups;
   - ordering policies;
   - post-merge validation.
4. Runtime catch-up fixtures:
   - first Ruby;
   - then one non-Ruby runtime to shake out contract assumptions;
   - then the remaining runtimes.

## Source-Region Identity Mapping

Source regions are the portable source-family read model. They should not be
named after Ruby implementation classes.

| Source-region field | Existing term | Mapping decision |
| --- | --- | --- |
| `address` | logical owner | Stable logical-owner address for structural owner regions. Interstitial regions may reference adjacent owner addresses through `previous_owner` and `next_owner`. |
| `region_kind: "owner"` | merge surface | The region is an owned merge surface when its body can be matched, delegated, merged, or reported independently. |
| `child_regions` | child group | A container owner's ordered child group. Each child region remains an owner or interstitial region with its own identity and span. |
| `region_kind: "interstitial"` | blank-line region / layout region | Layout, comments, imports, separators, headers, and footers that sit between owners. The region identity is positional and adjacency-aware. |
| `attached_comments` | attachment | Comments that are semantically attached to the next owner for matching and movement, while still preserved in the owner's source span. |
| `match_key` | owner identity | Runtime-local owner key used for matching. Portable reports should also expose address, owner kind, and confidence when matching is ambiguous. |
| `span` and `content` | source fragment | The exact source range and bytes/characters needed to reconstruct without global cleanup. |

Two constraints follow from this mapping:

- interstitial regions are first-class merge inputs, not formatting debris;
- child-group merge policies should operate on source-region sequences rather
  than on parser-specific node wrappers.

## Immediate Burn-Down Decisions

- The old Ruby base class names remain valid Ruby reference implementation
  names, but are not portable API names.
- The portable contract should be fixture roles and JSON-compatible report
  shapes.
- `reference/` remains read-only.
- Ruby should implement new prior-art tasks first only when the behavior is
  already supported or naturally expressible in `ast-merge`/`tree_haver`.
- Non-Ruby runtimes should catch up by contract lane, not by trying to mirror
  the Ruby object model.
