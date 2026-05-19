# Slice 1010: Owner-Selection Substrate

`ast-merge` should provide shared owner-selection helpers for recurring
matching shapes across merge gems.

The first Ruby slice extracts path-identity matching and selector-kind
classification. This distinguishes shared default owner selection, explicit
owner selectors, and logical-owner selectors while letting simple downstream
gems stop carrying duplicate path-matching implementations.
