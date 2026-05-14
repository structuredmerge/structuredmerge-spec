# Slice 752: Psych Provider Role Decision

## Goal

Decide the public role of `psych-merge` in the current Ruby implementation now
that `yaml-merge` owns the cross-language YAML family identity.

## Current Active Shape

The active Ruby workspace contains both packages:

- `ruby/gems/yaml-merge` is the YAML family package.
- `ruby/gems/psych-merge` is a Ruby package named after the Psych backend.

`psych-merge` depends on `yaml-merge`, registers the `psych` backend with
`TreeHaver::BackendRegistry`, delegates family behavior to `Yaml::Merge`, and
conforms to the shared YAML parse, structure, matching, merge, provider
profile, plan, and manifest-report fixtures.

## Options Considered

1. Retire `psych-merge` completely.
   This would simplify the package matrix but lose the Ruby-native provider
   package and break the old package name without a replacement path.
2. Treat `psych-merge` as only a legacy compatibility alias.
   This preserves installation compatibility but understates the current
   implementation: the package already exposes the Psych provider backend and
   has provider fixture coverage.
3. Treat `psych-merge` as the Ruby/Psych provider package for the YAML family.
   This preserves the package name, keeps provider-specific backend facts out
   of the family package, and matches the active code shape.

## Decision

Use option 3.

`yaml-merge` is the canonical YAML family package. `psych-merge` is the
Ruby/Psych provider package for that family. It may preserve old Ruby require
paths and names as compatibility affordances, but its public README role should
be backend/provider-specific rather than a separate YAML family or a generic
compatibility shim.

## Documentation Consequences

Generated package READMEs should point users this way:

- use `yaml-merge` when documenting portable YAML behavior;
- use `psych-merge` when documenting Ruby's native Psych backend/provider;
- do not copy old `Psych::Merge::*` class examples into `yaml-merge`;
- do not claim old Psych-only fuzzy matching, partial-template merge,
  comment preservation, freeze blocks, diff mapper, or emitter behavior until
  those features have portable fixtures and implementation plans.

## Boundary

This slice records the package role decision. It does not add the missing
Psych-derived feature fixtures from slice 751 and does not rewrite generated
READMEs.
