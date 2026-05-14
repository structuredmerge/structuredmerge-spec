# Slice 771: Kettle Jem Documentation Ownership

## Goal

Decide which `kettle-jem` documentation belongs in generated README template
partials and which belongs in source documentation.

## Decision

Use generated README partials for concise, user-facing operational docs that a
package user needs while applying templates:

- what `.kettle-jem.yml` controls;
- minimal configuration shape;
- strategies and per-file/pattern overrides;
- token substitution;
- freeze blocks;
- common workflow and runtime controls;
- basic plugin loading and registrar entrypoints.

Use source docs for deeper or unstable implementation material:

- complete configuration schema/reference;
- phase-by-phase internals;
- recipe authoring internals;
- plugin authoring guide with callback contracts;
- migration notes from old Kettle/Jem;
- troubleshooting and compatibility matrices that are too large for README
  partials.

Generated package READMEs should remain thin. The README partial mechanism is
an opt-in way for a package to own `Synopsis`, `Configuration`, and
`Basic Usage`, not a place to recreate the old heavyweight README.

## Current Ruby State

Ruby `kettle-jem` ships packaged README partials for the thin public docs. A
future docs/source pass should add durable source documentation for the complete
schema and plugin API, then link to it from the partials if needed.
