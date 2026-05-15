# Slice 800: Kettle Jem Ruby-Aware Boundary

## Goal

Separate old `kettle-jem` Ruby-aware merge value into portable Ruby merge
behavior, provider implementation details, and Kettle/Jem recipe policy before
porting any more helpers.

## Sources

Reviewed old Kettle/Jem helpers include:

- `reference/kettle-jem/lib/kettle/jem/prism_gemfile.rb`
- `reference/kettle-jem/lib/kettle/jem/prism_gemspec.rb`
- `reference/kettle-jem/lib/kettle/jem/prism_appraisals.rb`
- `reference/kettle-jem/lib/kettle/jem/classifiers/`
- `reference/kettle-jem/lib/kettle/jem/presets/`
- `reference/kettle-jem/lib/kettle/jem/gem_ruby_floor/`
- `reference/kettle-jem/lib/kettle/jem/modular_gemfiles.rb`

## Portable Ruby Merge Value

The following behavior belongs in the Ruby family contract only when fixtures
define parser-neutral expectations:

- Gemfile top-level declaration signatures for `source`, `git_source`,
  `gemspec`, `gem`, `group`, `platform`, and `eval_gemfile`.
- Gemspec declaration signatures for field assignments, dependency calls,
  file lists, version loader declarations, and self-dependency removal.
- Appraisals block signatures and dependency declarations.
- Ruby source leading-region preservation such as shebangs, magic comments,
  and leading comment block spacing.
- Cross-nesting duplicate detection for Bundler dependency declarations if it
  can be expressed without Kettle/Jem template assumptions.

These claims should remain in `ruby-merge` or the Ruby parser provider layer,
not in Kettle/Jem, once accepted by fixtures.

## Provider Or Implementation Details

The old Prism-specific helpers are not public contract names. Their value is
implementation strategy unless a fixture promotes the behavior:

- AST node classifiers for method calls, gem calls, gem groups, source calls,
  and appraisal blocks.
- Prism node traversal and literal extraction helpers.
- structural delete/edit helpers used to remove dependency declarations.
- recipe runner wiring around `Prism::Merge::SmartMerger`.

Active implementations may use equivalent internal shapes, but downstream
structuredmerge users should see normalized Ruby-family behavior and reports.

## Kettle/Jem Recipe Policy

The following behavior is Kettle/Jem-specific unless a future fixture proves a
portable Ruby merge need:

- applying packaged project templates to existing gems;
- preferring template-owned generated files while preserving project-owned
  regions;
- removing self-dependencies based on the active package name;
- Kettle/Jem conflict policy such as removing old `appraisal` declarations;
- local workspace override generation for modular Gemfiles;
- minimum-Ruby floor resolution and dependency comment alignment;
- gemspec variable harmonization during template application;
- README/gemspec metadata synchronization;
- RuboCop LTS and CI matrix token selection;
- scaffold cleanup from generated bundle-gem files.

These belong in active `ruby/gems/kettle-jem` recipe fixtures and APIs, not in
the generic Ruby merge layer.

## Current Active Surface

The active `kettle-jem` implementation already exposes Ruby-family template
application through:

- `Kettle::Jem.merge_config_template_source`
- `Kettle::Jem.merge_gemspec_template_source`
- `Kettle::Jem.template_file_type`
- `Kettle::Jem.plan_project`
- `Kettle::Jem.apply_project`

This is the right boundary: Kettle/Jem may call Ruby merge behavior for
Ruby-like files, then apply recipe-level policy around template ownership,
package facts, generated reports, and project-specific preservation.

## Fixture Direction

Continue the lane with fixture-backed policy slices before porting helpers:

1. Gemfile, Gemfile-like, gemspec, and Appraisals policy fixtures for the
   surviving old behaviors.
2. Classifier and dependency-policy fixtures that define parser-neutral
   reports or edits.
3. Kettle/Jem recipe fixtures for template-only policies such as modular
   Gemfiles, minimum-Ruby floor alignment, conflict removal, and scaffold
   cleanup.

Do not port old helper class names as a compatibility surface.
