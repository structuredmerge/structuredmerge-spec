# Slice 272: TOML Provider Manifest Report

## Goal

Allow TOML provider packages to produce manifest-wide reports for the shared
TOML family suites.

## Shared Behavior

This slice defines one TOML provider reporting contract:

1. a TOML provider MAY execute the shared TOML suite manifest,
2. provider-backed suite reports keep the same TOML family identity and case
   refs,
3. provider identity remains visible through the planned run contexts rather
   than changing the report envelope shape.
