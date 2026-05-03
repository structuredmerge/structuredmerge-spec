# Slice 684: Structured Edit Callable Destination Request Transport Envelope

## Goal

Standardize a versioned transport envelope for callable-destination structured
edit requests.

## Shared Behavior

This slice defines one shared callable-destination request envelope surface:

1. the envelope wraps one callable-destination structured edit request,
2. the envelope uses a stable kind and version,
3. import returns the original request when kind and version are supported.

## Notes

- This slice is the transport step for slice 683.
