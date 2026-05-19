# Slice 995: Ruby Fallback Scope Guard

Ruby should reject fallback activation that silently widens beyond the declared
scope. A whole-file fallback cannot replace an owned-region fallback unless a
policy explicitly permits that widening.

