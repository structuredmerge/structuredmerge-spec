## Slice 342: Mini Template Tree Convergence

`ast-merge` MUST provide a shared helper that evaluates whether a miniature
template tree converges after an applied result is used as the next destination
state.

Given:

1. the original template tree inputs,
2. an applied result tree,
3. the same destination remapping context,
4. the same strategy overrides,
5. the same token replacements,

the helper MUST produce the next execution plan and report:

1. `converged`
2. `pending_paths`

`converged` MUST be `true` only when the next execution plan contains no ready
entries and no blocked entries.
