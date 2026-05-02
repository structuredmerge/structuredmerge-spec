# Slice 526: Structured Edit Provider Execution Handoff Transport Envelope

## Goal

Standardize a transport envelope for the shared provider execution-handoff
contract.

## Shared Behavior

This slice defines one shared transport-envelope contract:

1. exporting a provider execution handoff yields an envelope with a stable
   `kind`,
2. the envelope carries one shared transport `version`,
3. the envelope carries the full provider execution-handoff payload unchanged.

## Notes

- This slice standardizes transport shape, not executor behavior.
