# Slice 1034: Ruby Golden-Master Baseline

## Status and scope

This slice pins the first post-release Ruby golden-master baseline used by the
Alef migration. It identifies the source and dependency state that supplied the
behavioral evidence and distinguishes callable APIs from documentation drift.
It does not claim every released behavior is desirable or that every public
Ruby object must become part of a portable ABI.

## Pinned source

The baseline is the clean `structuredmerge-ruby` checkout at revision
`e3ad14c9a52bf12d24783104eddbf557db247d46`, immediately after the v7.1.7
family checksum commit on 2026-09-01. The shared family version is 7.1.7.

The dependency lock set consists of the root `Gemfile.lock` and one tracked
`Gemfile.lock` for each of the 31 configured family members. Paths are sorted
bytewise, each file is hashed with SHA-256, and the resulting `sha256sum`
records are hashed again. The canonical aggregate is:

```text
f0711e6205f42a4f1c6b381cb1573ad068e9374ca8652136e8367a8569efd18b
```

The baseline runtime observation is Ruby 4.0.6 with Bundler 4.0.18 on
x86_64-linux. Runtime versions are execution evidence, not a restriction on
the Ruby implementation's declared engine/platform support.

## Callable behavior surface

The migration treats the following released entry points as evidence:

### Parse selection and parsing

- `TreeHaver.register_backend` registers a backend implementation.
- `TreeHaver.register_language` registers a language/provider mapping.
- `TreeHaver.parser_for` is the only parser-selection entry point used by merge
  packages. Explicit unavailable selections fail closed.
- The selected parser's `parse` method returns the backend-normalized tree
  facade.

Backend registry mutation and reset helpers are test/bootstrap mechanics. They
are evidence for lifecycle requirements, not end-user merge operations.

### Provider registration and portable operations

- `Ast::Merge.register_provider`, `resolve_provider`, and `dispatch_provider`
  own workflow-provider publication, selection, and dispatch.
- `Ast::Merge::ProviderContract::OPERATIONS` defines `analyze`, `diff2`,
  directional `merge2`, and base-aware `merge3`.
- `Ast::Merge::ProviderResult.build` owns the released provider-result envelope.
- Format/provider gems register implementations and must enter parsing through
  TreeHaver.

### Two-way templating

- Format-specific `SmartMerger` classes consume incoming/template and current
  destination source. `SmartMergerBase#merge_result` is the shared rich-result
  entry and `#merge` is its source-string projection.
- Portable callers should prefer `Ast::Merge.dispatch_provider(:merge2, ...)`
  when provider metadata, diagnostics, preservation evidence, and unsupported
  coverage matter.

### Three-way merge and Git integration

- `Ast::Merge.dispatch_provider(:merge3, ...)` is the portable operation.
- `Ast::Merge::Git.merge3` adapts that operation to Git role names and result
  fields.
- `Ast::Merge::Git.merge_files` and `Ast::Merge::Git.run` are file/CLI adapter
  surfaces; they are not separate merge algorithms.
- `Smorg::RB.run` owns the installed command dispatch for merge-driver,
  diff-driver, conflict review, language reporting, and Git installation.

### Directory templating

- `Ast::Template.run_template_directory_session_with_options` is the compact
  released options entry point.
- `run_template_directory_session_request`,
  `run_template_directory_session_runner_request`, and the entrypoint/command
  methods are the versioned request-dispatch surfaces.
- Plan/apply/reapply methods ultimately call the shared `Ast::Merge` template
  tree execution and provider adapters.

### Diagnostics and rendering

- Provider diagnostics, conflicts, changes, render reports, and verification
  are fields of the validated provider result, not side-channel strings.
- `Ast::Merge::SourceRender` owns language-neutral source-fragment assembly.
- Format emitters and structural-edit plans are implementation evidence behind
  provider results. Parser-specific AST objects are not portable rendering
  inputs.
- `Ast::Template` status, diagnostics, outcome, and inspection envelopes are
  the released directory-session reporting surfaces.

## Known defects and exclusions

The v7.1.7 `ast-template` README advertises
`Ast::Template.package_directory_session_request` and
`Ast::Template.run_package_directory_session`. Neither method exists in the
released source. These names are documentation drift and MUST NOT be encoded as
golden-master behavior. The actual session methods above remain authoritative
until the Ruby API deliberately adds aliases or corrects the documentation.

Internal helper visibility, object layout, cache state, provider load order,
and direct parser package calls are not portable merely because Ruby can
observe them. Known defects discovered later are recorded as expected failures
or exclusions before a non-Ruby implementation uses them as an oracle.

## Reproduction

From a clean checkout of the pinned revision:

```bash
git ls-files | rg '(^|/)Gemfile\.lock$' | sort \
  | xargs -d '\n' sha256sum \
  | sha256sum
```

The command must report 32 selected files and the aggregate above. A run that
uses a different source revision or lock aggregate records that state as a new
baseline; it does not overwrite this one.

## Exit effect

This completes only the Phase 0 task to record a Ruby revision and dependency
lock set. Full API inventory remains iterative: representative provider
snapshots, parser-specific extensions, shared ast-merge mechanics, and known
behavioral defects are tracked by later fixtures and differential tests.
