# Slice 19: Adapter Policy Support

## Goal

Allow parser-adapter metadata to expose supported policy references.

## Planned Scope

- extend adapter metadata with optional supported policy references
- keep supported policies distinct from result-level active policies
- seed the metadata surface with the already-validated JSON policy names

## Shared Behavior

This slice defines a narrow adapter capability contract:

1. adapter metadata may expose zero or more supported policy references
2. supported policies describe capability, not per-result activation
3. supported policies use the same `PolicyReference` vocabulary as result-level
   policy reporting
4. parser request vocabulary remains unchanged

## Shared Types

- `AdapterInfo` with optional `supported_policies`

## Notes

- This slice does not require a live adapter implementation yet.
- It makes policy capability visible before backend-specific adapters are added.
