WASIBOX_DEPENDENCIES := RUST WASI_SDK
WASIBOX_PKG_NAME := wasibox

WASIBOX_SRC_REV := 03e6a1d72e6b197d77519bd2ef31fc7220af25fb
WASIBOX_SRC_URL := $(call github_url,antmicro,wasibox,$(WASIBOX_SRC_REV))

WASIBOX_TARGET = $(WASIBOX_SRC_DIR)/target/wasm32-wasi/release/wasibox.wasm
WASIBOX_DIST := $(RESOURCES_DIR)/wasibox

$(eval $(call get-sources,WASIBOX))
$(eval $(call cargo-package,WASIBOX))
