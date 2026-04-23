## Slice 365: Template Directory Session Profile Configuration Outcome Report

The product-facing profile runner in `ast-template` MUST return the same
top-level outcome shape for configuration failures that it returns for
successful runs.

When a profile-based session request is not ready to run, the profile runner
MUST:

1. return a stable session outcome report instead of a host-language absence
   value,
2. preserve the requested mode in the returned outcome,
3. surface the configuration diagnostics from slice 364 unchanged, and
4. report zero planned and written file activity.

The fixture covers:

1. an unknown profile name, and
2. a known profile with missing template and destination roots in the
   overrides.
