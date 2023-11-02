define cargo-package
.PHONY: $(1)
$(1): $($(1)_DEPENDENCIES) $($(1)_TARGET) | $(RESOURCES_DIR)
	@cp $($(1)_TARGET) $($(1)_DIST)

$($(1)_SRC_ZIP): | $(BUILD_DIR)
	@wget -qO $($(1)_SRC_ZIP) $($(1)_SRC_URL)

$($(1)_SRC_DIR): $($(1)_SRC_ZIP) | $(BUILD_DIR)
	@unzip -od $(BUILD_DIR) $($(1)_SRC_ZIP)

.PHONY: $($(1)_TARGET)
$($(1)_TARGET): $($(1)_DEPENDENCIES) $($(1)_SRC_DIR) | $(BUILD_DIR)
	@CC="$(WASI_SDK_PATH)/bin/clang" $(CARGO) build --manifest-path $($(1)_SRC_DIR)/Cargo.toml --target wasm32-wasi --release

$(eval $(call apply-patches,$(1)))
endef
