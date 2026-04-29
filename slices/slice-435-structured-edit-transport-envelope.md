# Slice 435: Structured Edit Transport Envelope

## Goal

Expose a versioned transport envelope for portable structured-edit
applications.

## Shared Behavior

This slice defines one narrow transport contract:

1. a structured-edit application may be wrapped in a JSON envelope with a
   stable `kind` and `version`,
2. exporting and then importing the envelope yields the original application,
3. the enclosed request and result are unchanged by transport wrapping.

## Notes

- This slice applies transport framing after the shared execution-facing
  application shape is stable.
