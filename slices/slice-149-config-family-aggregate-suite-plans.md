# Slice 149: Config-Family Aggregate Suite Plans

## Goal

Plan the aggregated config-family named suites through one manifest.

## Shared Behavior

This slice defines one aggregate named-suite planning contract:

1. the aggregate config-family manifest MAY be planned through the existing
   named-suite planning helpers,
2. each family contributes its own plan context to the aggregate plan set,
3. the aggregate suite order remains stable as `json`, `text`, `toml`, `yaml`.
