# Slice 444: Structured Edit Batch Report Transport Envelope

## Goal

Expose a versioned transport envelope for portable structured-edit batch
reports.

## Shared Behavior

This slice defines one narrow transport contract:

1. a structured-edit batch report may be wrapped in a JSON envelope with a
   stable `kind` and `version`,
2. exporting and then importing the envelope yields the original batch report,
3. the enclosed per-report entries and batch diagnostics are unchanged by
   transport wrapping.

## Notes

- This slice applies transport framing after the shared batch report shape is
  stable.
