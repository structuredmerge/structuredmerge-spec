# Slice 167: Backend-Sensitive Aggregate Suite Plans

## Goal

Plan an aggregate manifest that combines the stable config-family suites with
backend-sensitive source-family suites.

## Shared Behavior

This slice defines one backend-sensitive aggregate planning contract:

1. an aggregate manifest MAY combine stable config-family suites with
   backend-sensitive source-family suites,
2. planning preserves backend requirements on the source-family parity roles,
3. ordinary stable suite planning remains unchanged within the same aggregate
   manifest.
