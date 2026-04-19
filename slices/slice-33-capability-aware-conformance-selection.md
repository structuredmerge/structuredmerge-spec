# Slice 33: Capability-Aware Conformance Selection

## Goal

Plan a portable way for conformance runners to skip or select cases based on
declared capability and backend support.

## Scope

- connect feature profiles to conformance selection
- keep skipped cases observable rather than silently dropped
- avoid binding conformance selection to any one host-language backend

## Notes

- This slice is planned ahead because the current backend-backed JSON adapter
  path is already narrower than whole-family support.
- The next step after slice 32 is likely capability-aware selection rather than
  more ad hoc backend-specific skip logic.
