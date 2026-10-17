# Slice 1044 — Family mise tasks template

**Parent epic:** kettle-family owns family-level project templating (family
`mise.toml` tasks) without depending on kettle-jem, using the shared
templating seam (ast-template) and the generic editing tool (ast-crispr).

Status: **implemented** (2026-10-17). Primitive in kettle-family (`Kettle::Family::MiseTasks`), `kettle-family mise-tasks` CLI (`--clean`, `--task-file`), managed-file baseline template shipped, kettle-jem config registration via psych-merge (keep_destination, destination-preference). Validated end-to-end against real mise on a family-root canary. YAML v1 scope: single-entry registration under the existing top-level `files:` mapping; nested YAML owner editing remains out of scope.

## Goal

kettle-family ships the family mise tasks as a kettle-family-owned artifact
and ensures a minimal reference to it in the destination's root `mise.toml`,
so the family root file stays consumer-owned while the task definitions stay
template-managed and upgradeable wholesale.

## Mechanism (mise semantics, verified against mise docs)

1. **Managed artifact: a TOML task file** (mise-task schema — tasks only).
   Proposed name `mise-family.tasks.toml`, non-hidden, at the family root.
   kettle-family owns this file outright: templating overwrites it wholesale
   on upgrade. No merge is required for it, ever.
2. **Reference: `[task_config]` in the root `mise.toml`** with
   `includes = ["mise-family.tasks.toml"]`. This is the only edit made to the
   consumer-owned root file.
   - Top-level `include` is NOT usable for this: mise errors on `[tasks]`
     inside included files (includes carry `[tools]`/`[env]`/`[vars]` only).
     `[task_config].includes` is the documented mechanism for exactly this
     ("an organization can publish a baseline that every repository uses").
3. **Precedence (mise):** a task defined in the root `mise.toml` wins over the
   same task name from a task file. Family tasks are therefore defaults, and
   consumers may override by redefinition. This must be documented as
   contract: redefinition is a deliberate divergence from the managed
   baseline, not an accident.

## Editing contract (ast-crispr, per-language adapters)

ast-crispr is the generic, adapter-neutral editing tool;
`ast-crispr-<lang>` packages are thin adapters (`read_ast`,
`structural_owners`, `comment_regions_for`, `structure_profile`). All
structural edits in this slice go through ast-crispr Actors with a language
adapter — no line-oriented string surgery.

1. **TOML adapter (new prerequisite):** `ast-crispr-toml` over the TOML
   parser-merge layer (`toml-merge` family `FileAnalysis`), mirroring
   `ast-crispr-markdown-markly`'s shape. Needed for:
   - ensuring the `[task_config]` include block in the root `mise.toml`
     (idempotent: present-and-correct is a no-op);
   - `--clean` duplicate removal (see below);
   - optionally ensuring `min_version` so old mise fails loudly instead of
     silently ignoring the includes.
2. **YAML adapter for the kettle-jem config:** ensure the template-managed
   registration for the managed artifact lands in the destination's
   kettle-jem config (`.kettle-jem.yml`) via ast-crispr over psych-backed
   YAML owners. Scope v1 to TOP-LEVEL mapping entries only — psych-merge
   addresses top-level `root_mapping_entries` today; nested YAML owners are a
   known, separately-scoped gap (see structuredmerge-block-editing skill).

## Redefinition detection

Compare task names defined in the managed task file against `[tasks.*]`
tables in the destination root `mise.toml`:

- **Default (no flag): WARN.** Redefinition is allowed — mise precedence
  makes the root definition win, and divergence is legitimate. The warning
  names the task(s) and states which definition wins.
- **`--clean` (opt-in, NOT default):** remove the duplicate `[tasks.*]`
  definitions from the root `mise.toml` via ast-crispr `Delete` through the
  TOML adapter, restoring the managed baseline. Never runs implicitly.

## Fixture plan

`structuredmerge/fixtures/templating/slice-1044-family-mise-tasks/`:

- root `mise.toml` before/after (include absent, present, present-but-wrong
  path, duplicate task definitions)
- managed task file (fixed content, version marker)
- kettle-jem config before/after (registration absent/present)
- redefinition warn cases and `--clean` removal cases
- conformance spec is fixture-driven (same pattern as slice-1043: hosts load
  the manifest; cases never duplicated inline in specs)

## Out of scope

- Nested YAML owner editing (psych-merge gap, separate slice).
- `git::`/`oci::` remote includes for the fragment (local vendored file is
  the delivery mechanism; offline-safe, versioned with the gem).
- Migrating existing per-family hand-authored `mise.toml` content (that is
  the consumer's call; the tool warns, `--clean` is the consumer's choice).
