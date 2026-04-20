`ast-merge` MUST provide a delegated child apply-plan helper.

Given:
- a family name, and
- delegated child group review state,

it MUST produce an ordered delegated child apply plan that:
- preserves accepted delegated child-group order,
- pairs each accepted group with the replayed apply decision that selected it,
- derives request identity from the delegated child group shape, and
- omits accepted groups that no longer have a matching apply decision in the
  supplied review state.

This slice turns accepted delegated child review state into a stable transport
shape that family packages can consume for actual delegated application.
