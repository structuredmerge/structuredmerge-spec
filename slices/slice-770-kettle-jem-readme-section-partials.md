# Slice 770: Kettle Jem README Section Partials

## Goal

Port the old `kettle-jem` README documentation pattern without making the thin
README generator special-case one package.

## Decision

The three maintainer-owned README sections can be filled by configured partials:

- `Synopsis`;
- `Configuration`;
- `Basic Usage`.

By default, generated READMEs still create those sections empty and preserve
destination-owned content. When `.kettle-jem.yml` configures a partial for one
of the sections, that section becomes template-owned for the run and is no
longer preserved from the destination.

## Configuration Shape

```yaml
templates:
  root: packaged
readme:
  section_partials:
    synopsis: readme/partials/synopsis.md
    configuration: readme/partials/configuration.md
    basic_usage: readme/partials/basic_usage.md
```

Partial paths resolve through the configured template root and use the same
`.example` source preference as other template files. Partial content is
resolved through the existing `{KJ|...}` token resolver.

## Implementation

Ruby `kettle-jem` now:

- discovers `readme.section_partials`;
- resolves partials from project or packaged template roots;
- accepts underscore and dash aliases such as `basic_usage`;
- renders partial bodies into the thin README;
- excludes configured partial sections from default README preservation;
- ships packaged example partials for its own README.

The packaged `kettle-jem` partials carry the first pass of migrated tool docs:
configuration shape, strategies, token substitution, freeze blocks, merge
recipe routing, workflow options, runtime controls, and plugin registration.

Other packages can use the same config shape to opt into managed README
section bodies without losing the default safety of empty manual sections.
