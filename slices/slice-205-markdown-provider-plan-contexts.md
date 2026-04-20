# Slice 205: Markdown Provider Plan Contexts

## Goal

Normalize native-provider plan contexts for the Markdown family.

## Shared Behavior

This slice defines one provider plan-context contract:

1. each native provider exposes a Markdown family profile,
2. each provider plan context reports its own backend identity,
3. provider plan contexts keep the same family-facing structure as the Markdown
   substrate plan context.

## Notes

- Provider plan contexts make provider-package selection visible to conformance
  planning without changing the Markdown family contract.
