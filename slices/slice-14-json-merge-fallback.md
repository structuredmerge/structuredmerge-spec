# Slice 14: JSON Merge Fallback

## Goal

Define the first explicit fallback contract for JSON merge recovery.

## Planned Scope

- destination-only fallback when the destination source fails only because of
  trailing commas
- strict baseline parse behavior remains unchanged
- fallback activation is observable through diagnostics
- rendered output remains strict canonical JSON

## Shared Behavior

This slice defines one narrow recovery rule:

1. template parsing remains strict and does not use fallback
2. destination parsing remains strict on the baseline path
3. if destination parsing fails because trailing commas are present, the merger
   may apply a constrained trailing-comma removal fallback
4. if fallback succeeds, merge succeeds and reports one
   `fallback_applied` diagnostic
5. fallback output is rendered as strict canonical JSON
6. if fallback does not apply or does not succeed, the original merge failure is
   preserved

## Shared Types

- `MergeResult` or equivalent with visible diagnostics
- `fallback_applied` diagnostic category

## Notes

- This slice makes fallback explicit without changing the baseline parse
  contract from slice 04.
- This slice does not authorize silent repair for arbitrary invalid JSON.
