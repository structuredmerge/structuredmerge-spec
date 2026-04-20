# Slice 147: YAML Family in Canonical Manifest

## Goal

Promote YAML into the canonical conformance manifest without yet promoting the
YAML named suite into the canonical suite set.

## Shared Behavior

This slice defines one canonical-manifest widening contract:

1. the canonical manifest MAY include the YAML family feature profile entry,
2. it MAY include the representative YAML roles `analysis`, `matching`, and
   `merge`,
3. this widening does not require the canonical suite set to add
   `yaml_portable` immediately.
