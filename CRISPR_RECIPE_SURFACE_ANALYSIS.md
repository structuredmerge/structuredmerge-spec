# CRISPR recipe surface analysis

## Scope

This analysis surveys the current **recipe surfaces** in `kettle-jem` and the shared recipe machinery in `ast-merge`, then evaluates where the new `Kettle::Jem::Crispr` model is a good fit:

1. **as-is**,
2. **with moderate CRISPR extensions**, or
3. **not as a replacement**.

The goal here is not to decide whether recipes should disappear. It is to separate two concerns that are currently bundled together:

- **distribution/orchestration** — YAML plus a companion directory of scripts
- **edit semantics** — how a concrete structural edit is identified, bounded, validated, and applied

## Current recipe system

### Shared infrastructure in `ast-merge`

The shared recipe substrate lives in:

- `ast-merge/lib/ast/merge/recipe/config.rb`
- `ast-merge/lib/ast/merge/recipe/runner.rb`
- `ast-merge/lib/ast/merge/recipe/script_loader.rb`

The important current contracts are:

- **content recipes** via `Runner#run_content(...)`
- **file recipes** via `Runner#run`
- **step kinds**:
  - `smart_merge`
  - `partial_merge`
  - `ruby_script`
- **partial targets**:
  - `kind: :navigable` via `injection.anchor` / `injection.boundary`
  - `kind: :key_path` via `injection.key_path`

Execution today is strictly **linear**. `Runner#process_file_steps` threads `current_content` through each step in order and does not model step dependencies, reusable intermediate artifacts, or explicit selector ownership contracts.

### Recipe loading and use in `kettle-jem`

The recipe entry points are:

- `kettle-jem/lib/kettle/jem/recipe_loader.rb`
- `kettle-jem/lib/kettle/jem/source_merger.rb`
- `kettle-jem/lib/kettle/jem/changelog_merger.rb`
- `kettle-jem/lib/kettle/jem/markdown_merger.rb`
- `kettle-jem/lib/kettle/jem/prism_gemfile.rb`
- `kettle-jem/lib/kettle/jem/prism_gemspec/merge_runtime_policy.rb`
- `kettle-jem/lib/kettle/jem/prism_appraisals.rb`

Available built-in recipe YAMLs:

- `gemfile.yml`
- `gemspec.yml`
- `rakefile.yml`
- `appraisals.yml`
- `markdown.yml`
- `readme.yml`
- `changelog.yml`
- `dotenv.yml`

All current `kettle-jem` recipes are effectively **content-oriented**. They are loaded as `Ast::Merge::Recipe::Config` and executed in-memory with caller-provided template and destination strings.

## What recipes are doing today

There are three materially different surfaces:

| Surface | Examples | What the recipe is really doing |
| --- | --- | --- |
| **Preset-only smart merge** | `gemfile.yml`, `markdown.yml`, `dotenv.yml` | Providing parser/merge configuration; little or no custom orchestration |
| **Smart merge plus scripted post/pre passes** | `gemspec.yml`, `rakefile.yml`, `appraisals.yml` | Combining merger execution with domain-specific cleanup / harmonization scripts |
| **Domain-specific scripted pipelines** | `readme.yml`, `changelog.yml` | Using recipes mainly as an ordered script pipeline; the real semantics live in Ruby code |

## Surface-by-surface assessment

### 1. `gemfile.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/prism_gemfile.rb`
- `kettle-jem/lib/kettle/jem/recipes/gemfile.yml`

**Current model**

- recipe mainly supplies merge configuration:
  - parser: `prism`
  - preference/add-missing
  - signature generator
  - node typing
- merge semantics are still dominated by `PrismGemfile.merge(...)` and the Gemfile-specific runtime policies around tombstones, filtering, and cross-nesting validation

**CRISPR fit**

- **As-is:** **poor replacement**
- **As a complement:** **good**

**Why**

This is not primarily a “find a structural owner and surgically edit it” problem. It is a **whole-document smart merge** problem with Gemfile-specific pre/post policy. CRISPR does not currently express:

- signature-driven multi-node alignment
- structural merge preference resolution
- Gemfile-local policy passes such as tombstone restoration/removal

**What CRISPR could do here**

- own narrowly targeted structural edits after merge
- replace some bespoke cleanup passes if they can be expressed as selector + owned-span edits

**Recommendation**

Keep recipe + merger as the main abstraction. Do not try to replace this surface with CRISPR.

---

### 2. `gemspec.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/prism_gemspec/merge_runtime_policy.rb`
- `kettle-jem/lib/kettle/jem/recipes/gemspec.yml`

**Current model**

- `smart_merge`
- `ruby_script` harmonization
- `ruby_script` version-loader rewrite
- additional runtime/context-aware post-processing after the recipe run

**CRISPR fit**

- **As-is:** **partial fit only**
- **With moderate extensions:** **good complement, still not a full replacement**

**Why**

The `rewrite_version_loader` step smells CRISPR-like: it is a bounded structural rewrite with explicit ownership. But the surface as a whole still depends on:

- whole-document smart merge
- content harmonization that is not just “select owner and replace span”
- domain rules around preserving destination structure in some scenarios

**Missing CRISPR features if we wanted more migration**

- richer replace-with-derived-content workflows
- selector reuse across multiple related edits
- better support for “merge first, then run constrained AST rewrites”

**Recommendation**

CRISPR should likely become a **step kind inside recipes** for some gemspec post-merge rewrites, not a replacement for the gemspec recipe surface.

---

### 3. `rakefile.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/recipes/rakefile.yml`
- scaffold-removal scripts under `kettle-jem/lib/kettle/jem/recipes/rakefile/`
- `kettle-jem/lib/kettle/jem/source_merger.rb`
- `kettle-drift/lib/kettle/drift/plugin.rb`

**Current model**

- several pre-merge cleanup scripts removing scaffolded content
- final `smart_merge`
- now also a separate CRISPR-based drift task injection path in `kettle-drift`

**CRISPR fit**

- **As-is:** **mixed, but promising**
- **With moderate extensions:** **strong fit for the cleanup/injection subset**

**Why**

The drift injection use case is exactly the kind of thing CRISPR is good at:

- deterministic owner selection
- explicit cardinality constraints
- bounded replace/move semantics

Some of the scaffold-removal scripts also look like they could migrate if their current logic can be restated as:

- selector
- owned span
- delete or replace

But the recipe still uses a full `smart_merge` for the general Rakefile merge, and that part should remain merger-driven.

**Missing CRISPR features**

- reusable selector libraries for common Ruby task/namespace owners
- possibly multi-match batch policies for cleanup passes

**Recommendation**

Rakefile is the best current **hybrid** candidate:

- keep recipe for overall merge orchestration
- migrate cleanup/injection steps to CRISPR-backed step kinds over time

---

### 4. `appraisals.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/prism_appraisals.rb`
- `kettle-jem/lib/kettle/jem/recipes/appraisals.yml`

**Current model**

- `smart_merge`
- `ruby_script` pruning of `ruby-X-Y` appraisals below minimum Ruby

**CRISPR fit**

- **As-is:** **partial fit**
- **With moderate extensions:** **good complement**

**Why**

The prune pass is much closer to CRISPR than the core merge step. It identifies specific structurally owned blocks and removes them based on runtime criteria. That is a selector-driven delete problem.

The overall surface still starts with whole-document smart merge, so CRISPR is not the replacement abstraction for the recipe itself.

**Recommendation**

Like gemspec and rakefile, Appraisals looks best as:

- recipe remains orchestrator
- CRISPR gradually absorbs selected post-merge cleanup edits

---

### 5. `markdown.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/recipes/markdown.yml`

**Current model**

- mostly a pure `smart_merge` preset

**CRISPR fit**

- **As-is:** **not needed**

**Why**

This recipe is essentially declarative merger configuration. CRISPR adds no obvious value unless there are later targeted markdown structural edits layered on top.

**Recommendation**

Leave this as a recipe/preset surface.

---

### 6. `readme.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/markdown_merger.rb`
- `kettle-jem/lib/kettle/jem/recipes/readme.yml`

**Current model**

- recipe is mostly an **ordered script pipeline**
- actual section preservation semantics live in Ruby:
  - `preserve_sections`
  - `preserve_h1`
- section replacement currently relies on Markdown PTM, not CRISPR
- H1 preservation is still a narrow line-based structural edit

**CRISPR fit**

- **As-is:** **not yet**
- **With meaningful extensions:** **very good candidate**

**Why**

This surface is conceptually CRISPR-friendly:

- select heading-owned sections
- preserve or replace owned spans
- potentially enforce constraints on cardinality and ownership

But the current CRISPR implementation does not yet provide:

- a Markdown adapter/backend
- heading/section owner selectors
- boundary-aware section ownership matching Markdown semantics
- a clean way to represent “preserve destination-owned subtree inside template-owned structure”

The H1 case also suggests CRISPR may eventually need a first-class concept for **syntactic owner** vs **document-region owner**, because the semantically relevant replacement region is not always the same as the parser’s default section boundary.

**Recommendation**

Readme is one of the strongest arguments for **expanding CRISPR**, not for replacing recipes. Once CRISPR has a Markdown backend and section-owner selectors, parts of `MarkdownMerger` could migrate cleanly.

---

### 7. `changelog.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/changelog_merger.rb`
- `kettle-jem/lib/kettle/jem/recipes/changelog.yml`

**Current model**

- script pipeline:
  - merge unreleased section
  - replace header
  - finalize
- heavy domain logic around Keep a Changelog semantics
- canonical ordering of subheadings
- preservation of destination unreleased items and version history

**CRISPR fit**

- **As-is:** **no**
- **With substantial extensions:** **partial fit**

**Why**

This is not just a structural-owner edit problem. It is also:

- a **domain normalization** problem
- an **ordered reconstruction** problem
- partly a **logical owner** problem (`Unreleased` content, version history, and link references have distinct roles)

CRISPR could help with bounded replace operations around the `Unreleased` section once a Markdown backend exists, but it does not currently model:

- canonical reordering of sibling groups
- derived-content synthesis from extracted items
- logical-owner preservation beyond direct structural replacement

These concepts are closer to the vocabulary in `archive/MERGE_RULESET_DRAFT_00.md` than to the current CRISPR implementation.

**Recommendation**

Do not target changelog as an early “recipes to CRISPR” migration. Use it instead as a requirements source for future CRISPR/logical-owner capabilities.

---

### 8. `dotenv.yml`

**Primary code paths**

- `kettle-jem/lib/kettle/jem/recipes/dotenv.yml`

**Current model**

- preset-only merge configuration
- destination wins

**CRISPR fit**

- **As-is:** **not needed**

**Why**

This is straightforward whole-document key-based smart merge. There is no obvious gain from replacing it with CRISPR.

**Recommendation**

Keep as recipe/preset.

## What CRISPR is good at right now

Right now CRISPR is strongest when all of these are true:

1. there is a meaningful **structural owner**,
2. ownership can be declared by a **selector** plus optional comment-region identity,
3. the edit is one of:
   - replace
   - insert
   - delete
   - move
4. correctness depends on explicit **cardinality constraints** and fail-closed behavior.

That maps well to:

- template-managed snippets
- scaffold cleanup of known structural units
- bounded post-merge rewrites

It does **not** yet replace:

- whole-document smart merge
- signature-driven correspondence between many nodes
- domain-specific synthesis/reordering pipelines
- YAML-distributed step orchestration

## Features CRISPR would need to absorb more recipe surfaces

### 1. Additional adapters/backends

Needed for CRISPR to be meaningfully cross-format:

- Markdown/Markly or Markdown-family adapter
- Psych/YAML key-path-aware adapter
- possibly Bash adapter if `.env`/shell-style structural edits are desired

Without those, CRISPR remains a strong **Ruby-first** structural tool even if its public vocabulary is generic.

### 2. Section/boundary ownership

Current CRISPR selectors are good for single-owner spans. Readme/changelog-style migrations need selectors that can express:

- heading-owned section
- heading until same-or-shallower heading
- key-path-owned subtree
- preamble/postlude/document-region ownership

This lines up directly with the ruleset draft’s language around **structural owners**, **comment regions**, and **gaps**.

### 3. Logical-owner support

For changelog- and markdown-like workflows, some artifacts behave more like **logical owners** than plain AST spans. Examples:

- version-history blocks
- link-reference blocks
- possibly freeze-managed semantic regions

If CRISPR grows here, it should probably do so in a way that mirrors `archive/MERGE_RULESET_DRAFT_00.md`, not as ad hoc one-off selectors.

### 4. Recipe integration instead of recipe replacement

The clearest near-term path is:

- keep recipes as the **distribution/orchestration package**
- add CRISPR as a **new step kind** or as a callable substrate inside `ruby_script` steps

That would preserve the current YAML + scripts packaging model while letting recipes delegate precise structural edits to CRISPR.

## Recommendation

### Short term

Do **not** try to replace recipes wholesale with CRISPR packages yet.

Instead:

1. keep recipes as the transport/distribution layer,
2. keep smart-merge and partial-merge where they are the right abstraction,
3. add CRISPR selectively for bounded structural edits inside recipe-driven flows.

### Best early migration targets

1. **Rakefile scaffold cleanup / plugin injection**
2. **Appraisals prune step**
3. **Selected gemspec post-merge rewrites**

These are the places where CRISPR already fits the problem shape well.

### Best requirements sources for future CRISPR growth

1. **README section preservation**
2. **CHANGELOG unreleased-section handling**
3. **Workflow snippet/key-path updates**

These surfaces expose the missing features CRISPR would need if it is going to become a more general AST-first editing substrate across document families.

## Recommendation on “split CRISPR into its own gem”

Not yet.

The code size is already large enough to justify thinking about extraction, but the abstraction boundary is still moving. The more important immediate question is:

> Is CRISPR a standalone package format, or is it a structural edit substrate that recipes and rulesets call into?

This analysis points toward the second answer for now.

The most credible extraction path would be:

1. move the generic selector/owner/edit substrate toward `ast-merge`,
2. align it more explicitly with the ruleset vocabulary,
3. prove at least one non-Ruby backend,
4. then decide whether the result wants to be:
   - part of `ast-merge`,
   - a sub-namespace within the merge family, or
   - a separate gem.

Until that is proven, a separate gem would likely freeze the boundary too early.
