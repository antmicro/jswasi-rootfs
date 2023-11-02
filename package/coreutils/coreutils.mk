COREUTILS_DEPENDENCIES := WASI_SDK

COREUTILS_SRC_REV := e402032a567051463ddfcda0951370b2c98ef21d
COREUTILS_SRC_URL := https://github.com/antmicro/coreutils/archive/$(COREUTILS_SRC_REV).zip
COREUTILS_SRC_ZIP := $(BUILD_DIR)/$(COREUTILS_SRC_REV).zip
COREUTILS_SRC_DIR := $(BUILD_DIR)/coreutils-$(COREUTILS_SRC_REV)

COREUTILS_TARGET := $(COREUTILS_SRC_DIR)/target/wasm32-wasi/release/coreutils.wasm
COREUTILS_DIST := $(RESOURCES_DIR)/coreutils

$(eval $(call cargo-package,COREUTILS))
