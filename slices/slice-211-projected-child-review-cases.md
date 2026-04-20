## Slice 211: Projected Child Review Cases

Defines how unresolved child-surface review cases are projected into a parent
review/result surface without losing child identity.

Rules:
- A projected child review case MUST preserve the original child case identity
  through `delegated_case_id`.
- A projected child review case MUST identify both the parent and child
  operation that produced the projected case.
- A projected child review case MUST preserve the child runtime surface path so
  replay and grouped application can safely target the original child surface.
- Projected child review cases MAY be emitted by top-level documents or by
  intermediate surfaces that themselves own child surfaces.
