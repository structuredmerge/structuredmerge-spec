# Slice 62: Family-Context Review Request

## Goal

Represent a strict-mode missing explicit family context as a resumable review
request rather than as a host-specific prompt.

## Scope

- define one review-request kind
- define one replayable decision action
- keep missing non-defaultable context as a hard configuration error

## Contract

This slice defines one narrow review-request contract:

1. review requests are stable data, not UI callbacks
2. a strict-mode missing explicit family context with a safe default available
   emits one blocking `family_context` request
3. the first replayable action is `accept_default_context`
4. missing context without a safe default remains an error without a request

## Shared Fixture

- `family-context-review-request.json`
