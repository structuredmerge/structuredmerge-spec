## Slice 362: Template Directory Session Options Report

`ast-template` MUST provide a normalized options object for the directory
session runner.

Given the same inputs used by the session-runner slice, the options-based
runner MUST:

1. accept one session options object,
2. read `mode`, roots, destination context, strategy settings, replacements,
   and allowed families from that object,
3. dispatch through the existing mode-based runner semantics unchanged, and
4. return the same top-level outcome report as the positional runner.

The fixture covers:

1. a `plan` run over the dry-run miniature tree,
2. an `apply` run over the multi-family apply tree, and
3. a `reapply` run after one prior apply against the same destination tree.
