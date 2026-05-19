# Slice 1015: Comment-Model Contract

`ast-merge` should treat comments as one merge-behavior axis rather than the
container for all trivia, layout, ownership, and render policy.

The Ruby release keeps the mature comment abstractions in the `Comment`
namespace, records them as normative reference abstractions, and documents
provider trackers and delimiter emission as implementation-local details.
Comment-free formats use `Capability.none`, unavailable support style, and the
separate `Layout` substrate.
