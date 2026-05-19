# Slice 979: Ruby Independent Function Owner Merge

Ruby should also prove the source-family owner behavior for top-level method
definitions. This is the Ruby analogue of two branches adding independent
functions to the same textual area in a source file.

The fixture keeps destination-owned top-level declarations in destination order
and appends template-only declarations when their owner identities do not
overlap.

