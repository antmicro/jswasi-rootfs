WASH_DEPENDENCIES := RUST WASI_SDK
WASH_PKG_NAME := wash

WASH_SRC_REV := a4563d213ffa37516178b3578bb77e26d3bbf0f9
WASH_SRC_URL := $(call github_url,antmicro,wash,$(WASH_SRC_REV))

WASH_TARGET = $(WASH_SRC_DIR)/target/wasm32-wasi/release/wash.wasm
WASH_DIST := $(RESOURCES_DIR)/wash

$(eval $(call get-sources,WASH))
$(eval $(call cargo-package,WASH))
