# Slice 981: Ruby Source-Owner Identity Profile

Ruby should expose a source-owner identity profile that can seed the portable
matching contract for source-family runtimes.

The profile records owner kind, owner name, parent/container scope, structural
identity, and a content-derived fallback identity. The Ruby implementation may
derive these from its current declaration and method projections, but the
fixture shape is the portable target for other runtimes.

