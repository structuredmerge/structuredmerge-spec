# Slice 779: Kettle Jem GitHub Workflow Parity

## Goal

Verify old `kettle-jem` GitHub workflow phase behavior against the active
recipe-pack runner.

## Active Coverage

The active Ruby `kettle-jem` runner covers the useful workflow behavior through
fixture-backed recipes:

- `.github/FUNDING.yml` synchronization;
- default CI workflow generation;
- framework matrix workflow generation;
- coverage workflow generation;
- obsolete workflow deletion;
- custom workflow snippet repair for permissions, concurrency, pinned actions,
  and coverage upload steps;
- OpenCollective workflow cleanup when OpenCollective is disabled;
- packaged workflow files through the template inventory.

## Decision

Do not port the old `GithubWorkflows` phase. Keep workflow behavior as explicit
recipes and template inventory entries.

The old `include` environment filter for `discord-notifier.yml` is superseded
by explicit `templates.entries` selection. Old appraisal/engine matrix pruning
is not claimed as parity until a dedicated fixture proves the current intended
policy.

## Boundary

No code change is needed for this slice. Existing active tests already verify
the current workflow behavior surface.

