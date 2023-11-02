define apply-patches
$(1)_PATCHES := $(wildcard $(PACKAGE_DIR)/$(shell echo $(1) | tr [:upper:] [:lower:])/*.patch)
$(1)_PATCH = $(foreach patch,$($(1)_PATCHES),$(addprefix $(1)_PATCH_,$(patch)))

.PHONY: $(1)_PATCH $(1)_PATCHES
$(1)_PATCH: $(1)_PATCHES

define patch-target
$(1)_PATCH_$(2): $($(1)_SRC_DIR)
	@cd $($(1)_SRC_DIR) && patch -p1 --forward <$2 || true
endef  # patch-target

$(foreach patch,$($(1)_PATCHES),$(eval $(call patch-taget,$(1),$(patch))))
endef  # apply-patches
