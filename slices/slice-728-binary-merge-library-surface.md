# Slice 728: Binary merge library surface

## Goal

Introduce the generic binary merge library layer that format families such as
ZIP, PNG, WebAssembly, PCAP, DICOM, and ELF can build on.

## Library Surface

The binary merge library owns portable operations that are not specific to one
file format:

1. byte-range validation and overlap checks;
2. preservation planning for unchanged ranges;
3. render-policy normalization;
4. binary diagnostic construction;
5. merge-report assembly;
6. fail-closed checks for executable, signed, encrypted, compressed, or
   checksum-protected regions.

## Non-Goals

The binary merge library does not own:

- Kaitai runtime loading;
- ZIP central-directory rendering;
- compression and decompression decisions;
- nested source-family parsing;
- format-specific signing policy.

Those belong to `tree_haver`, the format-family library, or the delegated
source-family library.

## Package Direction

The first publishable family should be named consistently with existing
families, for example `binary-merge` / `binarymerge`, with `zip-merge` layering
on top once ZIP fixtures and planner behavior are stable.
