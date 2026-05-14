# Slice 772: Kettle Jem Phase Engine Inventory

## Goal

Inventory the old `reference/kettle-jem` phase engine surfaces and decide how
they map to the active Ruby `kettle-jem` implementation.

## Old Surfaces

The old implementation split template work across explicit phase, task, plugin,
recipe, and drift-reporting objects:

- phases for config sync, dev container files, duplicate checks, environment
  templates, git hooks, GitHub workflows, license files, modular Gemfiles,
  quality config, remaining files, spec helper setup, phase context, phase
  stats, and template runs;
- presets for appraisals, dotenv, Gemfile, gemspec, JSON, Markdown, Rakefile,
  RBS, and YAML policy;
- YAML recipes and helper Ruby code for appraisals, changelog, dotenv, Gemfile,
  gemspec, Markdown, Rakefile, and README;
- plugin loader, registrar, and registry hooks;
- template checksum drift detection plus self-test manifest and reporter;
- setup, install, prepare, self-test, and template Rake tasks.

## Active Ruby State

The active Ruby gem has deliberately moved toward a fixture-backed recipe-pack
runner in `ruby/gems/kettle-jem/lib/kettle/jem.rb` instead of the old phase class
framework. Already-transferred behavior includes:

- plan/apply recipe reports and request/report envelopes;
- template source selection with `.example` preference;
- token projection and template token resolution;
- README style generation, top logo config, and README section partials;
- GitHub funding and workflow generation, workflow snippet sync, and obsolete
  workflow cleanup;
- OpenCollective cleanup;
- Rakefile scaffold cleanup;
- `.kettle-jem.yml` bootstrap;
- selected YAML, TOML, Ruby-family, Markdown, and generated-block merges.

## Decision

Do not port the old phase class framework wholesale. Use the active recipe-pack
and structured report model as the new implementation shape.

Preserve old phase value as fixture-backed recipe/report behavior where the
behavior is still current. Plugin lifecycle, phase stats/report parity,
checksum drift detection, self-test manifest/reporter parity, remaining-files
logic, environment template policy, and explicit retirement of old setup,
install, and prepare task APIs need follow-up fixtures before implementation.

Ruby `kettle-jem` owns Ruby gem templating. Shared cross-language kettle tools
should receive only generic README/template/session concepts that are already
portable through `ast-template` and the shared token resolver model.
