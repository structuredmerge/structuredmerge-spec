`ast-merge` MUST resolve nested child outputs keyed by delegated child surface
address into:

- a delegated child apply plan, and
- applied child outputs keyed by delegated child operation id.

Given:

- delegated child operations,
- nested child outputs keyed by `surface_address`,
- a `request_id_prefix`,
- and a `default_family`,

the shared helper MUST:

1. match each nested child output to a delegated child operation by exact
   surface address
2. synthesize a delegated child apply-plan entry for each matched surface
3. preserve the delegated child operation id when producing applied child
   outputs
4. use `surface.metadata.family` when present, otherwise fall back to
   `default_family`

The resulting apply plan and applied child outputs MUST preserve the input
order of nested child outputs.
