# Slice 146: YAML Family Manifest Report

## Goal

Report a YAML family manifest through host-specific planning contexts.

## Shared Behavior

This slice defines one YAML manifest-reporting contract:

1. a YAML family manifest MAY be reported through the existing manifest report
   helper,
2. host-specific YAML contexts determine which suite plans are available,
3. the observable report remains the ordinary suite report envelope plus
   manifest diagnostics.
