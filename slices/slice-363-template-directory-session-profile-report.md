## Slice 363: Template Directory Session Profile Report

`ast-template` MUST provide session profile resolution above raw session
options.

Given a session profile set and a selected profile name, the profile-based
runner MUST:

1. resolve a named profile into the normalized session options shape,
2. allow explicit overrides to replace profile fields,
3. preserve mode-specific behavior from the options-based runner, and
4. return the same top-level outcome report as the options-based runner.

The fixture covers:

1. a `plan` run resolved from a named dry-run profile,
2. an `apply` run resolved from a named apply profile, and
3. a `reapply` run resolved from the apply profile with an explicit mode
   override.
