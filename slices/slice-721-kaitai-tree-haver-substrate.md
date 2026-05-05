# Slice 721: Kaitai tree-haver substrate

Structured binary formats can participate in the same structured-merge model as
source, config, and documentation formats when a schema-backed parser exposes a
stable tree. A Kaitai-backed `tree_haver` substrate exposes decoded binary
records as mergeable tree nodes while format-family packages remain responsible
for family-specific rendering.

The substrate contract adds:

1. a `kaitai-struct` backend reference in the `kaitai` backend family;
2. adapter and feature-profile helpers for schema-backed binary trees;
3. a normalized Kaitai tree-node shape with schema path, byte span, decoded
   field values, and child nodes.

This slice does not define PNG, ZIP, DICOM, ELF, or other family-specific merge
behavior. Those families can layer rulesets and renderers on top of the Kaitai
tree substrate.
