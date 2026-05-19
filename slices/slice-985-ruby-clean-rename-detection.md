# Slice 985: Ruby Clean Rename Detection

Ruby should expose rename detection as an explicit capability rather than an
always-on merge behavior.

This fixture reports a same-parent method rename where the method body is
unchanged after normalizing the owner name. The report is a planning signal; it
does not require the merge path to silently apply rename policy.

