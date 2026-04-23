## Slice 355: Template Directory Default Adapter Discovery Report

`ast-template` MUST provide a conventional default family-adapter discovery
policy above the explicit registry seam.

Given:

1. a real multi-family miniature template tree apply run,
2. default adapter discovery over the installed adapter set, and
3. default adapter discovery constrained by an explicit family filter,

the default-discovery session helper MUST:

1. expose the discovered adapter families in stable sorted order,
2. dispatch through the discovered adapter registry without requiring the caller
   to build that registry manually,
3. preserve the same apply behavior as the explicit full registry when all
   required families are discovered, and
4. preserve the same deterministic `configuration_error` blocking behavior when
   the discovered adapter set does not cover a required family.
