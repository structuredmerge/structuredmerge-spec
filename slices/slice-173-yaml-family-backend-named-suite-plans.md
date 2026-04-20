# Slice 173: YAML Family Backend Named Suite Plans

## Goal

Plan the YAML named suite through non-default backend contexts without changing
suite shape.

## Shared Behavior

This slice defines one YAML named-suite planning contract:

1. a YAML named suite MAY be planned through any supported YAML backend
   context,
2. the YAML suite definition remains stable across those backends,
3. only the backend-specific feature profile varies between those named suite
   plans.
