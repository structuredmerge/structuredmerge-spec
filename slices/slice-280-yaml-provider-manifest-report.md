## Slice 280: YAML Provider Manifest Report

## Goal

Allow YAML provider packages to produce manifest-wide reports for the shared
YAML suite descriptors.

## Shared Behavior

This slice defines one YAML provider reporting contract:

1. a YAML provider MAY execute the shared YAML suite manifest,
2. provider-backed suite reports keep the same YAML family identity and case
   references as the substrate,
3. provider identity remains visible through the planned run contexts rather
   than through renamed suites.

## Notes

- the first TypeScript YAML provider report contract is `js-yaml`
