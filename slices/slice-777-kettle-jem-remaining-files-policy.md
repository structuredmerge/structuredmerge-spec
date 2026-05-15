# Slice 777: Kettle Jem Remaining Files Policy

## Goal

Evaluate old `kettle-jem` remaining-files phase behavior and keep the parts
that still apply to the active template inventory runner.

## Old Behavior Kept

The old phase discovered template files not handled by earlier dedicated
phases, stripped `.example` / `.no-osc.example` suffixes, renamed
`gem.gemspec` to the destination gemspec, and applied file-type specific merge
policy.

The active runner already covers that shape through template source
preferences, template inventory, strategy selection, source preference, token
resolution, and file-type merge behavior.

Two old policies still needed explicit active coverage:

- `REEK` and `bin/setup` are copy-only-when-missing template files.
- `.github/COPILOT_INSTRUCTIONS.md` is a legacy destination for canonical
  `.github/copilot_instructions.md` and should be deleted once the canonical
  path is applied or already present.

## Decision

Do not port the old `RemainingFiles` phase. Preserve these as template
preference metadata and deletion recipes in the active recipe-pack runner.

## Boundary

Environment-file review and task abort behavior is not implemented here. That
needs a separate decision because the active runner is report-first and should
not grow interactive phase behavior implicitly.

