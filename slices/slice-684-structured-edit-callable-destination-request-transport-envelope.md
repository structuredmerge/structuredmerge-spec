# Slice 684: Structured Edit Request Transport Envelope

## Goal

Standardize a versioned transport envelope for shared structured edit requests.

## Shared Behavior

This slice defines one shared request envelope surface:

1. the envelope wraps one structured edit request,
2. the envelope uses a stable kind and version,
3. import returns the original request when kind and version are supported.

## Notes

- This slice uses the callable-destination request from slice 683 as the
  conformance payload without making callable destination part of the envelope
  kind.
