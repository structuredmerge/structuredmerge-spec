# Slice 150: Config-Family Aggregate Manifest Report

## Goal

Report the aggregate config-family manifest through the existing conformance
report helpers.

## Shared Behavior

This slice defines one aggregate manifest-reporting contract:

1. the aggregate config-family manifest MAY be reported through the existing
   manifest report helper,
2. explicit contexts MAY be mixed with defaulted contexts in one aggregate
   report,
3. the observable result remains the ordinary manifest report envelope plus
   manifest diagnostics.
