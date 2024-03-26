define apply-patches

$($(1)_SRC_DIR)/.patched: $($(1)_PATCHES) $($(1)_SRC_DIR)
	cd $($(1)_SRC_DIR) && \
	for patch in $($(1)_PATCHES); do \
		patch -p1 --forward <$$$${patch} || true; \
	done
	touch $$@

.PHONY: $(1)_PATCH
$(1)_PATCH: $($(1)_PATCHES) $($(1)_SRC_DIR)/.patched

endef  # apply-patches
