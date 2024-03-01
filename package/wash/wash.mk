WASH_DEPENDENCIES := RUST WASI_SDK

WASH_SRC_REV := a4563d213ffa37516178b3578bb77e26d3bbf0f9
WASH_SRC_URL := https://github.com/antmicro/wash/archive/$(WASH_SRC_REV).zip
WASH_SRC_ZIP := $(BUILD_DIR)/$(WASH_SRC_REV).zip
WASH_SRC_DIR := $(BUILD_DIR)/wash-$(WASH_SRC_REV)

WASH_TARGET := $(WASH_SRC_DIR)/target/wasm32-wasi/release/wash.wasm
WASH_DIST := $(RESOURCES_DIR)/wash

$(eval $(call cargo-package,WASH))
