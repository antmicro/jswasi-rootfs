OX_DEPENDENCIES := RUST WASI_SDK

OX_SRC_REV := ff1fbd2b9947f69b2f8f4d63b62ebbfc801c38bf
OX_SRC_URL := https://github.com/antmicro/ox/archive/$(OX_SRC_REV).zip
OX_SRC_ZIP := $(BUILD_DIR)/$(OX_SRC_REV).zip
OX_SRC_DIR := $(BUILD_DIR)/ox-$(OX_SRC_REV)

OX_TARGET := $(OX_SRC_DIR)/target/wasm32-wasi/release/ox.wasm
OX_DIST := $(RESOURCES_DIR)/ox
OX_DIST_EXTRA := $(RESOURCES_DIR)/ox.ron

$(RESOURCES_DIR)/ox.ron: $(OX_SRC_DIR)/config/ox.ron | $(RESOURCES_DIR)
	@cp $(OX_SRC_DIR)/config/ox.ron $(RESOURCES_DIR)/ox.ron

$(eval $(call cargo-package,OX))
