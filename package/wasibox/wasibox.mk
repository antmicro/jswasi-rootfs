WASIBOX_DEPENDENCIES := RUST WASI_SDK
WASIBOX_PKG_NAME := wasibox

WASIBOX_SRC_REV := b31b9309f8bc8929c628fb245bc5e5b56a07b472
WASIBOX_SRC_URL := $(call github_url,antmicro,wasibox,$(WASIBOX_SRC_REV))

WASIBOX_TARGET = $(WASIBOX_SRC_DIR)/target/wasm32-wasi/release/wasibox.wasm
WASIBOX_DIST := $(RESOURCES_DIR)/wasibox

$(eval $(call get-sources,WASIBOX))
$(eval $(call cargo-package,WASIBOX))
