# Slice 780: Kettle Jem Obsolete Task Retirement

## Goal

Explicitly retire old `kettle-jem` setup/install/prepare task APIs that do not
belong in the active recipe-pack runner.

## Retired Old APIs

- `Kettle::Jem::SetupCLI`
- `Kettle::Jem::Tasks::InstallTask`
- `Kettle::Jem::Tasks::PrepareTask`
- old `kettle:jem:install`, `kettle:jem:prepare`, and bootstrap handoff task
  semantics

## Decision

Do not port the old bootstrap orchestration. It mixed template application,
Bundler setup, interactive prompts, mise trust, local commits, preflight
dependency edits, and Rake task chaining.

The active API is:

- `Kettle::Jem.plan_project`
- `Kettle::Jem.apply_project`
- `Kettle::Jem.plan_readme_style`
- `Kettle::Jem.apply_readme_style`
- report utilities and self-test helpers from slices 774-776

Generated Rakefile stubs may continue to reference user-facing kettle tasks as
compatibility affordances, but the old implementation classes are not active
contracts.

## Future Work

If a setup command is needed later, it should be designed as a new explicit
command over the active plan/apply/report APIs, not a port of the old task
classes.

