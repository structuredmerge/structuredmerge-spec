# Slice 144: YAML Family Suite Definitions

## Goal

Expose the YAML family through the shared suite-descriptor mechanism.

## Shared Behavior

This slice defines one YAML suite-definition contract:

1. a YAML manifest MAY define one portable suite descriptor,
2. that descriptor references the representative YAML roles `analysis`,
   `matching`, and `merge`,
3. the suite-definition shape is identical to the one used by other families.
