# Slice 778: Kettle Jem Specialized Phase Policy Evaluation

## Goal

Evaluate old specialized `kettle-jem` phase policies for environment templates,
git hooks, devcontainer files, quality config, modular Gemfiles, and license
files.

## Decision

Do not port these phase classes. The active recipe-pack runner owns template
inventory and application through source preferences, strategies, token
resolution, file-type merge policy, and structured reports.

## Current Active Coverage

- Environment templates: `.env.local` maps to `.env.local.example`; `.envrc`
  and `.env.local.example` are discovered through template inventory.
- Git hooks: `.git-hooks/` files are discovered and applied as packaged
  templates.
- Devcontainer: `.devcontainer/` files are discovered and applied as packaged
  templates.
- Quality config: `.qlty/qlty.toml` is discovered and applied as a TOML
  template.
- Modular Gemfiles: `gemfiles/modular/**` are discovered and active tests cover
  RuboCop token projection plus Gemfile convergence.
- License files: selected license files are generated from configured or
  gemspec licenses, and README/LICENSE token projection is covered.

## Future Fixture Work

These old behaviors need dedicated fixtures before implementation claims:

- dotenv-aware merge for `.env.local.example`;
- environment-file review diagnostics or policy gates without interactive task
  aborts;
- git-hook executable mode metadata;
- optional global git-hook template installation as an explicit command or
  profile, not implicit template application;
- devcontainer JSON merge with trailing-comma destination tolerance;
- shell-script merge policy for devcontainer scripts and git hooks;
- license-file pruning/migration beyond explicit selected template entries.

## Boundary

The old phase classes, prompts, helper copy APIs, and interactive abort behavior
remain retired. Any future behavior should be expressed as fixture-backed
recipes, diagnostics, or explicit commands.

