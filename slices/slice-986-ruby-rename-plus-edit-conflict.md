# Slice 986: Ruby Rename-Plus-Edit Conflict

Ruby should report incompatible rename-plus-edit changes as an explicit
conflict. The report is scoped to the owned region and uses the rename-detection
policy profile rather than silently choosing one branch.

This fixture covers a base method that both branches rename differently while
also changing the body.

