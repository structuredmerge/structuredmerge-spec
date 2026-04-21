# Slice 285 - Provider Backend Override Rejection

## Status

Draft

## Purpose

Provider packages expose one concrete backend identity. When a caller explicitly
requests a different backend through a provider package entrypoint, the provider
must reject that request instead of silently delegating or falling back.

This keeps backend ownership explicit:

- substrate packages may route to their registered backends
- provider packages may only serve the backend they register

## Contract

For any provider package parse or merge entrypoint:

1. If `backend` is omitted, the provider must use its own registered backend.
2. If `backend` equals the provider's backend id, the provider must proceed.
3. If `backend` is any other id, the provider must fail with
   `category: unsupported_feature`.

## Diagnostic Shape

The rejection diagnostic must:

- use severity `error`
- use category `unsupported_feature`
- mention the requested backend id in the message

Recommended message form:

- `Unsupported <Family> backend <backend-id>.`

Examples:

- `Unsupported Markdown backend kreuzberg-language-pack.`
- `Unsupported TOML backend parslet.`
- `Unsupported Ruby backend kreuzberg-language-pack.`

## Non-Goals

This slice does not define substrate-family override behavior. Family packages
may support backend selection through `tree-haver` or `tree_haver` registration.
This slice only constrains provider packages.
