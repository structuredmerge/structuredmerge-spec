# Slice 984: Ruby Ambiguous Visibility Owner Identity

Ruby should report repeated source-owner identities that require ordered cursor
matching. This fixture covers same-name methods that appear under different
visibility sections in one class.

The behavior is not a hard conflict by itself, but it must be observable because
matching by name alone would collapse distinct owners.

