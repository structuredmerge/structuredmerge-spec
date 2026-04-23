## Slice 356: Template Directory Adapter Capability Report

`ast-template` MUST provide a preflight adapter-capability report over a planned
template tree.

Given:

1. a real multi-family miniature template tree plan,
2. an adapter set that covers every required family, and
3. an adapter set that omits one required family,

the adapter-capability report helper MUST:

1. report the required families in stable sorted order,
2. report the available adapter families in stable sorted order,
3. report the missing required families in stable sorted order, and
4. expose a boolean readiness signal that is `true` only when no required
   family is missing.
