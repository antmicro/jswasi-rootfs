WASIBOX_DEPENDENCIES := RUST WASI_SDK
WASIBOX_PKG_NAME := wasibox

WASIBOX_SRC_REV := bc3b80029fa533beec113416cfe6d446ee3c352b
WASIBOX_SRC_URL := $(call github_url,antmicro,wasibox,$(WASIBOX_SRC_REV))

WASIBOX_TARGET = $(WASIBOX_SRC_DIR)/target/wasm32-wasi/release/wasibox.wasm
WASIBOX_DIST := $(RESOURCES_DIR)/wasibox

$(eval $(call get-sources,WASIBOX))
$(eval $(call cargo-package,WASIBOX))
