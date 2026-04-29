# Slice 454: Structured Edit Provider Execution Request Transport Envelope

## Goal

Wrap the shared provider execution request in a versioned transport envelope.

## Shared Behavior

This slice defines one shared transport contract:

1. the envelope carries `kind`, `version`, and one provider execution request,
2. export remains deterministic,
3. import remains lossless for supported versions.

## Notes

- This slice standardizes transport only, not execution.
