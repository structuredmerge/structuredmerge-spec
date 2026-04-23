## Slice 366: Template Directory Session Options Configuration Outcome Report

The product-facing options runner in `ast-template` MUST return the same
top-level outcome shape for configuration failures that it returns for
successful runs.

When a direct options-based session request is not ready to run, the options
runner MUST:

1. return a stable session outcome report instead of relying on host-language
   argument failure behavior,
2. preserve the requested mode in the returned outcome,
3. surface the configuration diagnostics from slice 364 unchanged, and
4. report zero planned and written file activity.

The fixture covers:

1. a `plan` request missing both roots, and
2. an `apply` request missing the destination root.
