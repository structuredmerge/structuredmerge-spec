## Slice 354: Template Directory Adapter Registry Report

`ast-template` MUST provide an explicit family-adapter registry seam above
`ast-merge`.

Given:

1. a real multi-family miniature template tree apply run,
2. a full registry that includes adapters for every required family, and
3. a partial registry that omits one required family adapter,

the adapter-registry session helper MUST:

1. dispatch `merge_prepared_content` entries by `classification.family`,
2. expose the registered adapter families in stable sorted order,
3. surface adapter-selection failures as `configuration_error` diagnostics from
   the product layer, and
4. block only the entries whose required family adapter is missing while still
   applying the entries whose family adapters are present.
