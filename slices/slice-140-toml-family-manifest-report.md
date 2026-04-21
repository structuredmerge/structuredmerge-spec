# Slice 140: TOML Family Manifest Report

## Goal

Report a TOML family manifest through the substrate planning context.

## Shared Behavior

This slice defines one TOML substrate reporting contract:

1. a TOML family manifest MAY be reported through the existing manifest report
   helper,
2. the TOML substrate context determines which suite plans are available from
   the family package,
3. the observable report remains the ordinary suite report envelope plus
   manifest diagnostics.
