# Slice 199: Markdown Matching

## Goal

Define the first portable Markdown owner matching rule.

## Shared Behavior

This slice defines one Markdown matching contract:

1. Markdown owners match first by stable path equality,
2. matched owners preserve destination order,
3. unmatched template and destination owners remain observable.

## Notes

- This keeps the first Markdown matching slice aligned with the early JSON and
  YAML matching slices.
- More semantic Markdown matching may follow later once the substrate is
  better informed by additional backends.
