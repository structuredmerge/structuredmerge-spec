# Slice 983: Ruby Fallback Policy Profile

Ruby should expose the source-family fallback policy as an observable profile
before fallback activation is broadened across runtimes.

The profile declares trigger names, fallback scopes, and the baseline provider
as an integration point. It intentionally does not hardcode a concrete VCS
command into portable semantics.

