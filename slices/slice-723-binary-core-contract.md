# Slice 723: Binary core contract

Schema-backed binary formats need a portable core vocabulary before individual
families such as ZIP, PNG, WebAssembly, PCAP, DICOM, or ELF define writable
behavior. The binary core contract layers on top of the portable byte-location
contract and describes decoded values, render decisions, diagnostics, and merge
reports without committing to a specific binary format renderer.

The contract adds:

1. decoded scalar values for schema-backed binary fields: string, integer,
   float, boolean, enum, bytes, timestamp, opaque, and null;
2. render policy records that explain whether a byte range is preserved,
   rewritten, inserted, deleted, delegated to a nested family, or rejected;
3. binary diagnostics anchored to schema paths and optional byte ranges;
4. binary merge reports that summarize matched schema paths, preserved ranges,
   rewritten nodes, checksum/length updates, nested dispatches, and diagnostics.

The default safety posture is conservative. Format families may preserve known
unchanged byte ranges by default, but changed structured nodes must be rendered
by the owning binary format family. Load-bearing or executable mutations remain
rejected unless a family explicitly marks the operation safe.
