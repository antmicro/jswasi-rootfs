WASIBOX_DEPENDENCIES := RUST WASI_SDK

WASIBOX_SRC_REV := bc3b80029fa533beec113416cfe6d446ee3c352b
WASIBOX_SRC_URL := https://github.com/antmicro/wasibox/archive/$(WASIBOX_SRC_REV).zip
WASIBOX_SRC_ZIP := $(BUILD_DIR)/$(WASIBOX_SRC_REV).zip
WASIBOX_SRC_DIR := $(BUILD_DIR)/wasibox-$(WASIBOX_SRC_REV)

WASIBOX_TARGET := $(WASIBOX_SRC_DIR)/target/wasm32-wasi/release/wasibox.wasm
WASIBOX_DIST := $(RESOURCES_DIR)/wasibox

$(eval $(call cargo-package,WASIBOX))
