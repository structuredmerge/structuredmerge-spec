# Slice 733: ZIP render provider boundary

## Goal

Define the plugin boundary between portable ZIP merge planning and the concrete
ZIP library used to render final archive bytes.

## Motivation

Shared tooling can plan archive membership, preserved byte ranges, nested
dispatch, checksum updates, and diagnostics. It should not own the final ZIP
writer implementation in the same way Markdown and JSON families can route
parsing/rendering through family or provider libraries.

## Contract

A ZIP render provider accepts:

1. the original source, destination, and optional ancestor archive bytes;
2. a reviewed ZIP merge plan;
3. delegated member outputs already rendered by their owning nested families;
4. renderer options for compression method, timestamp policy, entry ordering,
   comments, Zip64 handling, and safety policy.

It returns:

1. final archive bytes;
2. an archive inventory for the rendered result;
3. preserved-range evidence for copied compressed bytes;
4. checksum, size, and central-directory update evidence;
5. diagnostics for unsupported writer features or unsafe render requests.

## Provider Boundary

The ZIP family substrate owns portable inventory, matching, planning, and report
normalization. Provider packages own concrete library integration, such as host
standard-library ZIP writers or ecosystem-specific ZIP packages.

Providers may expose more than one rendering strategy. A full-rewrite strategy
is sufficient for basic archive correctness. A raw-preserving strategy is
required before a provider can claim byte-stable preservation for unchanged
members: it must copy reviewed preserved local records and compressed payloads
from source bytes, then rewrite central-directory offsets and end records around
those copied ranges.

Providers must preserve the same family-facing contracts for:

- archive inventory;
- member decisions;
- render diagnostics;
- binary merge reports;
- replayable render evidence.

Nested member outputs are provider inputs, not provider-owned merge work. A
provider receives final uncompressed bytes for delegated members after the
reviewed nested-execution machinery has accepted those child outputs.

## Safety

Shared tooling must reject final application when the selected provider cannot
prove the archive is readable and cannot account for required checksum, size,
offset, and central-directory updates.

Provider-specific metadata may be attached through generic extension entries
until a later shared slice defines stronger normalization.
