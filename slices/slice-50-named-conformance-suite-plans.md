# Slice 50: Named Conformance Suite Plans

## Goal

Plan all declared suite descriptors through stable manifest ordering.

## Scope

- compose suite-selector ordering with suite-definition lookup and family plan
  contexts
- avoid rebuilding aggregate suite-descriptor planning in each host language
- keep aggregate planning deterministic

## Contract

This slice defines one small aggregate planning contract:

1. an aggregate suite-descriptor planning helper consumes a manifest and family
   plan contexts
2. it resolves suite selectors in stable manifest order
3. it plans each suite whose family has a declared plan context
4. it returns ordered suite-descriptor plan entries
5. suites without a matching family plan context are omitted

## Shared Fixture

- `named-suite-plans.json`

## Notes

- This slice is aggregate planning only.
- It does not add aggregate execution or reporting.
