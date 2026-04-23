## Slice 361: Template Directory Session Runner Report

`ast-template` MUST provide a single mode-based directory session runner.

Given the same template-directory inputs used by the prior `ast-template`
session slices, the runner helper MUST:

1. accept an explicit session `mode`,
2. dispatch `plan` to the dry-run outcome path,
3. dispatch `apply` to the apply outcome path,
4. dispatch `reapply` to the reapply outcome path, and
5. always return the stable top-level outcome report shape.

The fixture covers:

1. a `plan` run over the dry-run miniature tree,
2. an `apply` run over the multi-family apply tree, and
3. a `reapply` run over the same destination after one prior apply, yielding the
   expected no-op outcome shape.
