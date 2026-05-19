# Slice 1001: Ruby VCS Tool Integration

Ruby should expose a merge-driver and merge-tool integration contract for host
VCS tools. The contract covers Git and Jujutsu roles, host-provided marker
settings, optional enhanced markers, audit artifacts, timeout budgets, and
clear diagnostics for skipped structured merge, fallback, and invocation errors.
