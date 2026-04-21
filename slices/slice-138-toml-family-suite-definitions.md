# Slice 138: TOML Family Suite Definitions

## Goal

Expose the TOML family through the shared suite-descriptor mechanism.

## Shared Behavior

This slice defines one TOML suite-definition contract:

1. a TOML manifest MAY define one portable suite descriptor,
2. that descriptor references the representative TOML roles `analysis`,
   `matching`, and `merge`,
3. the suite-definition shape is identical to the one used by other families.
