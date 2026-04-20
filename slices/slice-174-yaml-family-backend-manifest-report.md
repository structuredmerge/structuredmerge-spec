# Slice 174: YAML Family Backend Manifest Report

## Goal

Report the YAML family manifest through non-default backend contexts.

## Shared Behavior

This slice defines one YAML manifest-reporting contract:

1. a YAML family manifest MAY be reported through any supported YAML backend
   context,
2. backend-specific YAML contexts determine which suite plans are available,
3. the observable report remains the ordinary suite report envelope plus
   manifest diagnostics.
