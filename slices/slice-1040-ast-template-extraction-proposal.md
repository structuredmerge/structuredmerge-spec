# Slice 1040: ast-template Extraction for Generic Templating (proposal)

## Status and scope

Status: **proposal** (2026-10-16).

`ast-template` was extracted from `kettle-jem` to be the generic templating
seam of the StructuredMerge stack — the layer that owns template mechanics for
any target — and then went unused. This slice puts it to work by moving the
generically-relevant templating machinery out of `kettle-jem` into
`ast-template` (Ruby), refactoring `kettle-jem` to consume it, and adding a
second consumer: `kettle-family` templating the family-root `mise.toml` (and
later other family-root files) without depending on `kettle-jem` for that
path.

Layering after this slice:

```
kettle-jem (gem profile: facts, recipes, template tree, gem config schema)
kettle-family (family profile: .kettle-family.yml facts, family-root templates)
        \                    /
         v                  v
        ast-template  (generic engine: tokens, strategies, plan/apply,
                       merge dispatch, destination config, lockfile semantics)
         |
         v
        ast-merge family (per-format mergers)
```

`kettle-family` keeps its existing `kettle-jem` dependency for the gem
templating runtime (member templating still runs `kettle-jem install` per
member); only the family-root templating path is kettle-jem-free.

## Evidence for the gap

Verified against source at time of writing:

1. `ast-template` 7.1.10 (both the released gem and the monorepo checkout at
   `structuredmerge/ruby/gems/ast-template`) contains only transport schemas
   and bridges: `ast/template.rb` (versioned session transport constants,
   `readme_family_*` token helpers), `typed_core_bridge.rb` (report field
   shapes), `rust_host_provider.rb` (explicitly `report_and_plan_only`;
   "Template execution and filesystem mutation remain Ruby-owned"). There is
   no Ruby execution machinery in the gem.
2. Nothing consumes it: no gemspec in the workspace declares an `ast-template`
   dependency; `kettle-jem` neither depends on nor requires it.
3. All generic templating machinery lives in `kettle-jem`'s `jem.rb`
   (~20k lines, ~1,400 method definitions), interleaved with gem-domain code:
   token resolution (`{KJ|...}`), strategy application (`keep_destination`,
   `accept_template`, merge with `preference:`), destination config loading,
   template tree plan/apply, per-format merge dispatch, and lockfile
   (`kettle-jem.lock`) semantics.
4. The two-consumer shape already exists and is hurting: 12 family-root
   `mise.toml` files are hand-maintained copies of the same task bodies. On
   2026-10-16 all 12 carried the same one-source bundler-version lookup bug
   (fixed by hand-sweep; this slice makes that class of drift
   template-managed instead).

## Non-goals (initial)

- Wholesale extraction of `jem.rb`. Extraction is scoped to what the
  two-consumer shape needs (below); the rest of the machinery moves later,
  driven by additional consumers or by deliberate follow-on slices.
- The Rust kernel. It is the future direction of the suite, but this slice is
  Ruby-only. See "Contract anchoring" for how the Ruby work stays aligned so
  the kernel remains a drop-in rather than a redesign.
- Removing `kettle-family`'s `kettle-jem` dependency.

## Boundary rule

`ast-template`'s implementation may never depend on or branch on consumer
domain concepts — no gems, gemspecs, RubyGems, READMEs, workflows, recipes,
or family config. Profiles (kettle-jem's gem facts, kettle-family's family
facts) supply domain content; the engine supplies mechanics.

Carve-out (per Peter): documentation may use gem-specific *examples* — a
docstring or `@example` that shows how a generic mechanism applies to a gem
case is fine. The prohibition is on implementation coupling, not on
illustrative references.

### Existing violations to fix as part of this alignment

`ast/template.rb` already violates the boundary: `readme_family_language_aliases`,
`readme_family_token_values`, `README_FAMILY_LANGUAGE_ORDER`,
`README_FAMILY_LANGUAGE_LABELS`, and the README-family section application
helpers are StructuredMerge-multi-language-family domain content sitting in
the generic layer. They move up to their real consumer during this slice.
(The same leakage exists in the Rust kernel's `ast-template` crate —
`readme_family_section` functions in `lib.rs` — recorded here so the kernel
side is cleaned up when it next moves; not in this slice's scope.)

## Contract anchoring (requirement, not aspiration)

Alignment with the existing transport contract is a hard requirement, and the
contract must be anchored somewhere real — not merely Ruby code agreeing with
a Ruby bridge, which would be self-fulfilling.

The anchor already exists as a mechanism: `structuredmerge/spec` slices define
the semantics, and `structuredmerge/fixtures` holds shared conformance
fixtures that any host runs against (precedent: `ast-template`'s own
`session_integration_spec.rb` loads
`fixtures/diagnostics/slice-353-template-directory-session-report` and the
`fixtures/conformance/slice-24-manifest` profiles).

Therefore, for every contract surface this slice's extraction touches:

1. The surface is defined or extended in a spec slice (this one, or a
   follow-on per surface) with its transport schema named.
2. A conformance fixture (or fixture set) is added under
   `structuredmerge/fixtures` expressing the surface's expected behavior —
   e.g. token-resolution cases, strategy-application cases, plan/apply session
   reports.
3. The Ruby implementation's specs consume those fixtures rather than
   hand-rolled inline expectations, so the fixture — an artifact the future
   Rust and TypeScript hosts must also satisfy — is the source of truth.

Surfaces already named in the existing bridge schemas (and therefore already
partially anchored): `TemplateTokenConfig`, `TemplateStrategyOverride`,
template directory plan/preview/run/apply reports, session
status/diagnostics/outcome envelopes.

## Extraction scope (initial)

The machinery both consumers need, moved from `jem.rb` into `ast-template`,
with `kettle-jem` refactored to consume it the same day each piece lands
(no parallel copies — the jem.rb copy is deleted in the move, and
kettle-jem's suite is the regression net, green after each piece):

1. **Token resolution** — `{TOKEN|...}`-style pattern resolution with segment
   rules, mapped to the `TemplateTokenConfig` schema. First cut: self-contained,
   heavily covered by kettle-jem's existing suite, zero gem-domain references.
2. **Strategy application** — the strategy enum (`accept_template`,
   `keep_destination`, merge with `preference:`, `raw_copy`) and per-path
   overrides, mapped to `TemplateStrategyOverride`.
3. **Destination config loading** — strategy overrides and options from a
   consumer-named config file (kettle-jem supplies
   `.structuredmerge/kettle-jem.yml`; kettle-family supplies its own).
4. **Template tree plan/apply** — walk a template tree, produce plan entries,
   preview/apply with session reports matching the existing report schemas.
5. **Merge dispatch** — route by file type to the ast-merge family mergers
   (toml-merge for `*.toml`, etc.). The family-root `mise.toml` case exercises
   exactly one route, which is the point of choosing it.
6. **Lockfile semantics** — template/destination hashing and convergence
   detection (`kettle-jem.lock`'s `dest_sha256` mechanics), with the lockfile
   name supplied by the consumer.

Stays in `kettle-jem` (gem profile): gemspec facts, README generation,
workflow generation, appraisal integration, recipes, the `kettle-jem.yml`
config schema, and the gem template tree content.

## Consumer 2: family-root templating in kettle-family

A new `kettle-family` capability templates the family root — initially
`mise.toml` — via `ast-template`:

- Facts derive from `.kettle-family.yml` (family name → env prefix such as
  `APPRAISAL_RB_DEV`; `mode:` → monorepo vs sibling-repo wiring). Facts are
  the source of truth; rendered output is never scraped for generation.
- The template lives in `kettle-family` (e.g. `templates/mise.toml.example`),
  merging into destinations with `preference: destination` so family-specific
  extras survive.
- Acceptance: after templating, the 12 family roots carry the updated task
  bodies while each keeps its own env wiring — verified by a sweep identical
  to the manual one performed on 2026-10-16.
- Operational tail: a templated `mise.toml` change requires `mise trust` per
  root; the tooling must print or perform that step.

This consumer is deliberately small (one file, TOML, stable node identity)
because its job is to prove the seam end-to-end: consumer profile → engine →
merger → destination, with no gem involved.

## Phasing

1. Contract slices/fixtures for the extraction surfaces (token resolution
   first).
2. Vertical extraction, one machinery piece at a time; kettle-jem consumes
   each piece the day it lands; kettle-jem suite green after each move.
3. Evict the `readme_family_*` violations from `ast-template`.
4. `kettle-family` family-root templating (consumer 2) on the extracted
   engine.
5. Expand extraction later as additional consumers or follow-on slices
   justify.

## Open questions

- Lockfile naming and discovery for the family profile (kettle-family root
  has no existing lock convention).
- Whether family-root destination config is a new file or keys inside
  `.kettle-family.yml`.
- How much of kettle-jem's recipe system maps onto the engine now versus
  staying kettle-jem-internal until a third consumer appears.
