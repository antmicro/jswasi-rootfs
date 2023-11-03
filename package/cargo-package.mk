define cargo-package
$(eval $(call apply-patches,$(1)))

.PHONY: $(1)
$(1): $($(1)_DEPENDENCIES) $($(1)_TARGET) | $(RESOURCES_DIR)
	@cp $($(1)_TARGET) $($(1)_DIST)

$($(1)_SRC_ZIP): | $(BUILD_DIR)
ifdef $(1)_SRC_ZIP_CMDS
	$(call $(1)_SRC_ZIP_CMDS)
else
	@wget -qO $($(1)_SRC_ZIP) $($(1)_SRC_URL)
endif

$($(1)_SRC_DIR): $($(1)_SRC_ZIP) | $(BUILD_DIR)
ifdef $(1)_SRC_DIR_CMDS
	$(call $(1)_SRC_DIR_CMDS)
else
	@unzip -od $(BUILD_DIR) $($(1)_SRC_ZIP)
endif

.PHONY: $($(1)_TARGET)
$($(1)_TARGET): $($(1)_DEPENDENCIES) $($(1)_SRC_DIR) $($(1)_PATCHES) $($(1)_DIST_EXTRA) | $(BUILD_DIR)
	@CC="$(WASI_SDK_PATH)/bin/clang" $(CARGO) build --manifest-path $($(1)_SRC_DIR)/Cargo.toml --target wasm32-wasi --release
endef
