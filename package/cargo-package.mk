define cargo-package
.PHONY: $(1)
$(1): $($(1)_DEPENDENCIES) $($(1)_TARGET) | $(OUT_DIR)
	@cp $($(1)_TARGET) $($(1)_DIST)

$(foreach element,$($(1)_DEPENDENCIES),$(eval $(call make-dependency,$(element))))

$($(1)_SRC_ZIP): | $(BUILD_DIR)
	@wget -qO $($(1)_SRC_ZIP) $($(1)_SRC_URL)

$($(1)_SRC_DIR): $($(1)_SRC_ZIP) | $(BUILD_DIR)
	@unzip -d $(BUILD_DIR) $($(1)_SRC_ZIP)

.PHONY: $($(1)_TARGET)
$($(1)_TARGET): $($(1)_DEPENDENCIES) $($(1)_SRC_DIR) | $(BUILD_DIR)
	@CC="$(WASI_SDK_PATH)/bin/clang" cargo +wasi_extended build --manifest-path $($(1)_SRC_DIR)/Cargo.toml --target wasm32-wasi --release
endef
