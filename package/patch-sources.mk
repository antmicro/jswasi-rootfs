define apply-patches

$($(1)_PATCHES): %: $($(1)_SRC_DIR)
	cd $($(1)_SRC_DIR) && patch -p1 --forward <$$@ || true

.PHONY: $(1)_PATCH $($(1)_PATCHES)
$(1)_PATCH: $($(1)_PATCHES)

endef  # apply-patches
