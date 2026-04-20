# Slice 227: Projected Child Review Groups

Projected child review cases MAY be grouped by delegated apply group so replay
and grouped application can preserve child-session identity without flattening
multiple child cases into unrelated parent-level decisions.

Rules:

- A projected child review group MUST preserve `delegated_apply_group`.
- A projected child review group MUST preserve the shared parent and child
  operation identity for all grouped cases.
- A projected child review group MUST preserve
  `delegated_runtime_surface_path`.
- Group membership MUST preserve encounter order for both `case_id` and
  `delegated_case_id`.
- Group construction MUST be stable for the same ordered case list.
