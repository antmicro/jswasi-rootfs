define cargo-package
.PHONY: $(1)
$(1): $($(1)_DEPENDENCIES) $($(1)_TARGET) | $(RESOURCES_DIR)
	@cp $($(1)_TARGET) $($(1)_DIST)

.PHONY: $($(1)_TARGET)
$($(1)_TARGET): $($(1)_DEPENDENCIES) $($(1)_SRC_DIR) $($(1)_PATCHES) $($(1)_DIST_EXTRA) | $(BUILD_DIR)
	@CC="$(WASI_SDK_PATH)/bin/clang" $(CARGO) build --manifest-path $($(1)_SRC_DIR)/Cargo.toml --target wasm32-wasi --release $($(1)_CARGO_OPTS)
endef
