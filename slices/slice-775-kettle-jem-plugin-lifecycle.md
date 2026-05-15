# Slice 775: Kettle Jem Plugin Lifecycle

## Goal

Evaluate the old `kettle-jem` plugin lifecycle and preserve the part that still
fits the active recipe-pack runner.

## Old Behavior

The old implementation loaded plugin names from configuration, required each
plugin by gem name, resolved a constant from the dashed name, and called
`register_kettle_jem_plugin(registrar)`.

The registrar exposed:

- `before_phase(phase, &block)`
- `after_phase(phase, &block)`
- `on_phase(phase, timing: :before | :after, &block)`

Callbacks received keyword arguments for the phase context, actor, phase name,
phase stats, and plugin name.

## Decision

Keep the loader, registry, and registrar contract, but do not reintroduce the
old phase framework. The active compatibility point is apply-time
`after_phase(:remaining_files)`, which runs after the recipe-pack runner has
written changed files.

Plan mode remains non-mutating. Plugins are loaded and reported, but lifecycle
callbacks do not run during planning.

## Implemented

Ruby `kettle-jem` now exposes:

- `Kettle::Jem::PluginLoader`
- `Kettle::Jem::PluginRegistrar`
- `Kettle::Jem::PluginRegistry`
- apply-time plugin lifecycle diagnostics and file-change reporting

The compatibility context exposes `project_root`, `mode`, `facts`,
`recipe_pack`, `recipe_reports`, `changed_files`, `diagnostics`, `helpers`, and
`out`. `helpers.record_template_result(path, action)` records plugin file
changes into the apply report, and `out.report_detail` / `out.warning` append
structured diagnostics.

## Boundary

Only apply-time `after_phase(:remaining_files)` is wired into the active runner.
Other registered callbacks remain available in the registry API, but they are
not invoked by the current recipe-pack runner until a fixture-backed phase
equivalent exists.

