# Slice 140: TOML Family Manifest Report

## Goal

Report a TOML family manifest through backend-specific planning contexts.

## Shared Behavior

This slice defines one TOML manifest-reporting contract:

1. a TOML family manifest MAY be reported through the existing manifest report
   helper,
2. backend-specific TOML contexts determine which suite plans are available,
3. the observable report remains the ordinary suite report envelope plus
   manifest diagnostics.
