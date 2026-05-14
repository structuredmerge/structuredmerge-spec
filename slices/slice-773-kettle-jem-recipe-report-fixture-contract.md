# Slice 773: Kettle Jem Recipe Report Fixture Contract

## Goal

Define fixtures for old `kettle-jem` recipe/report behavior that still needs to
be represented in the active recipe-pack runner.

## Already Covered

The active Ruby implementation already emits structured plan/apply reports for
each recipe:

- recipe name, version, target path, provider family, backend, primitive, and
  selectors;
- request and report envelopes;
- final content, change status, diagnostics, metadata, and step reports;
- delete-file metadata for cleanup recipes;
- template source preference and token metadata;
- README style metadata for README template recipes.

These are the right replacement for the old phase stats as the primary
machine-readable execution surface.

## Fixture Targets Still Needed

Add implementation fixtures for these surviving old report surfaces:

- templating environment snapshot: loaded merge gems, versions, source labels,
  local path flags, workspace root, and local-checkout warning;
- template checksum drift: added, changed, removed files plus summary and detail
  lines;
- self-test manifest comparison: matched, changed, added, removed, and skipped
  file classes;
- self-test markdown summary: score, divergence, changed/new/unexpected/skipped
  sections, and diff artifact count;
- run report markdown: started/finished/status, project root, output dir,
  environment table, optional template commit, warnings, errors, and template
  file changes.

## Decision

Keep the active recipe execution report as the canonical API. Reintroduce the
old report value as explicit diagnostics/report fixtures layered around the
recipe-pack runner, not as a resurrection of old phase objects.

The next implementation work should add focused tests for checksum drift and
self-test report rendering first. Those features are small, deterministic, and
independent from plugin lifecycle decisions.
