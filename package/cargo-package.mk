define cargo-package

$(eval $(1)_SOURCES := $(shell find $($(1)_SRC_DIR) -type f -name '*.rs'))
$(eval $(1)_TARGET := $($(1)_SRC_DIR)/target/wasm32-wasip1/release/$($(1)_PKG_NAME).wasm)

$($(1)_SRC_DIR)/.installed: | $($(1)_DEPENDENCIES) $($(1)_TARGET) $$(ROOTFS_DIR)
ifndef $(1)_INSTALL_CMDS
	$$(INSTALL) -D $($(1)_TARGET) $($(1)_DIST)
ifdef $(1)_INSTALL_CMDS_EXTRA
	$(call $(1)_INSTALL_CMDS_EXTRA)
endif  # INSTALL_CMDS_EXTRA
else
	$(call $(1)_INSTALL_CMDS)
endif  # INSTALL_CMDS
	touch $($(1)_SRC_DIR)/.installed

.PHONY: $(1)
$(1): $($(1)_SRC_DIR)/.installed

$($(1)_TARGET): $($(1)_SOURCES) $($(1)_SRC_DIR) $(if $($(1)_PATCHES),$(1)_PATCH,) | $$(BUILD_DIR) $($(1)_DEPENDENCIES)
	CC="$$(WASI_SDK_PATH)/bin/clang" $$(CARGO) build --manifest-path $$($(1)_SRC_DIR)/Cargo.toml --target wasm32-wasip1 --release $($(1)_CARGO_OPTS)
	wasm-strip "$$@"
endef  # cargo-package
