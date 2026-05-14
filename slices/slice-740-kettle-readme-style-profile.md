# Slice 740: Kettle README Style Profile

## Goal

Define the cross-language README generation contract for the new Kettle tools.

The old `kettle-jem` README template preserved a useful authoring pattern:
most README content is generated, while only Synopsis, Configuration, and Basic
Usage are owned by the project maintainer. The new tools MUST keep that pattern
but render a thinner default README that hides secondary material behind
`<details>` blocks and works for Ruby, Go, Rust, and TypeScript packages.

## Shared Behavior

Implementations MUST expose a `.kettle-jem.yml`-equivalent README configuration
profile. Ruby MAY continue to use `.kettle-jem.yml`; other ecosystems SHOULD use
the same nested keys in their native kettle configuration file unless a direct
`.kettle-jem.yml` compatibility file is intentionally supported.

README generation MUST:

- preserve heading emoji from the old `kettle-jem` template for every managed
  heading level where the old template used emoji,
- require the document H1 to begin with a project emoji followed by one space,
- keep the project emoji configurable per package,
- preserve maintainer-owned content in Synopsis, Configuration, and Basic Usage,
- support old heading aliases such as Summary -> Synopsis and Usage -> Basic
  Usage,
- keep the Synopsis available as structured input for README family partial
  injection when a package opts into a package family,
- remove Ruby secure-installation prose from the new Ruby README template,
- include the Ruby hostile RubyGems takeover section only for Ruby packages,
- include the Security section only when `SECURITY.md` exists,
- include FLOSS Funding by default for MIT packages and only by opt-in for
  non-MIT packages,
- generate License files and README License content from configured SPDX
  licenses,
- include all blamed source authors in generated copyright notices,
- report configured but missing README integrations rather than rendering broken
  links for services such as Codecov, Coveralls, or QLTY.

## Logos

The logo row is optional. When enabled, it MUST contain at most three logos. Each
logo MUST declare one of four normalized types:

- `language`
- `org`
- `project`
- `affiliated_project`

Logo image URLs SHOULD be resolved from `https://logos.galtzo.com` using a
stable slug convention. Implementations MUST report unresolved logo slugs rather
than silently emitting broken image references.

## Badges

Generated READMEs SHOULD keep a small visible badge cloud. Less critical badges
MUST be eligible for a collapsed `<details>` section.

The visible core SHOULD prioritize:

- package version,
- license,
- primary CI status,
- security policy when present,
- primary documentation link when configured.

Badge rendering MUST be dynamic. If a service is not configured or no matching
project file/URL exists, the badge SHOULD be omitted and the generator report
SHOULD list that integration as remaining setup work unless it has been disabled
in config.

## Managed Section Order

The default generated README MUST use this section order:

1. Logos (optional, no heading)
2. Project Name (`# <emoji> <name>`)
3. Badges
4. if badges are not green let me know
5. Hostile RubyGems Takeover (Ruby only)
6. Synopsis
7. Info you can shake a stick at
8. Installation
9. Configuration
10. Basic Usage
11. FLOSS Funding (optional by license/config)
12. Security (only with `SECURITY.md`)
13. Contributing
14. Versioning
15. License
16. A request for help

## Thin README Policy

The default README SHOULD keep the main path short:

- project identity, badges, Synopsis, Installation, Configuration, and Basic
  Usage should remain immediately visible,
- dense compatibility, federated forge, enterprise support, contributor
  tooling, versioning edge cases, and large funding/social blocks should be
  collapsed unless the package opts into an expanded profile,
- collapsed summaries MUST still retain the old heading emoji where applicable.

## Acceptance Data

The fixture for this slice defines:

1. normalized config keys for README style, project emoji, logo row, badge
   groups, family partial injection, preserved sections, conditional sections,
   integrations, license generation, and generator reports,
2. the expected managed section order and ecosystem applicability,
3. old `kettle-jem` sources that each behavior is derived from,
4. explicit transfer decisions where the new template intentionally differs from
   the old template.

## Boundaries

- This slice defines the README style and generator contract.
- It does not require all packages to have final prose in Synopsis,
  Configuration, or Basic Usage.
- It does not prescribe exact badge image URLs beyond requiring dynamic service
  detection and stable logo slug resolution.
- Per-language install snippets are ecosystem-specific and should be filled by
  each kettle tool.
