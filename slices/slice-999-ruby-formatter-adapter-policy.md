# Slice 999: Ruby Formatter Adapter Policy

Ruby should expose formatter handling as an optional post-merge adapter. The
policy must make clear that formatter output does not prove semantic correctness
and that portable fixtures only execute formatter behavior when they explicitly
opt into a formatter profile.
