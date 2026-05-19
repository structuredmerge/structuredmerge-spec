# Slice 1014: Render Source-Shaper Contract

`ast-merge` should carry the ruleset `render` directive into merge-facing
runtime objects while keeping concrete serialization format-specific.

The Ruby substrate stores `render_family` on runtime declarations and feature
profiles. Shared conformance owns render metadata, source-fragment retention,
reparse-after-render verification, and common emitter preservation helpers.
Concrete syntax serialization and provider-native rendering remain in
format-specific adapters.
