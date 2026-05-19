# Slice 1000: Ruby AST-Node Merge Strategy

Ruby should preserve an optional finer-grained AST-node merge profile for cases
where owner-level merge is too coarse. The public contract stays at the
ruleset/fixture level so implementations can choose entity-level, AST-level,
line-level, or hybrid algorithms.
