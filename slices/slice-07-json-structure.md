# Slice 07: JSON Structural Analysis

## Goal

Move from parse acceptance to merge-relevant JSON structure.

## Planned Scope

- object and array owner selection
- structural node wrappers
- stable match-key candidates for JSON object members
- fixture cases for object and array analysis

## Why This Slice Exists

Parse acceptance alone is not enough to support merge semantics. This slice is
intended to connect the parse contract from slice 04 to future JSON merge
behavior without collapsing immediately into full merge logic.
