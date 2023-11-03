WASIBOX_DEPENDENCIES := RUST WASI_SDK

WASIBOX_SRC_REV := 60d25df87ae48d2c53e753b7291f092b1313ca5a
WASIBOX_SRC_URL := https://github.com/antmicro/wasibox/archive/$(WASIBOX_SRC_REV).zip
WASIBOX_SRC_ZIP := $(BUILD_DIR)/$(WASIBOX_SRC_REV).zip
WASIBOX_SRC_DIR := $(BUILD_DIR)/wasibox-$(WASIBOX_SRC_REV)

WASIBOX_TARGET := $(WASIBOX_SRC_DIR)/target/wasm32-wasi/release/wasibox.wasm
WASIBOX_DIST := $(RESOURCES_DIR)/wasibox

$(eval $(call cargo-package,WASIBOX))
