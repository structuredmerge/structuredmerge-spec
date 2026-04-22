`ast-merge` shared nested-merge execution MUST preserve failure boundaries from
the orchestration stages.

The shared helper MUST:

1. return parent-merge failure unchanged when parent merge does not produce an
   output
2. return delegated-child discovery failure unchanged when discovery does not
   produce delegated child operations
3. return delegated-child output resolution rejection unchanged when nested
   child outputs reference missing delegated child surfaces
4. skip the reconstruction callback for any failed prior stage

This contract keeps nested-merge orchestration deterministic while allowing
family packages to supply language-specific merge, discovery, and reconstruction
behavior.
