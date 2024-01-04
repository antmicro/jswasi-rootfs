COREUTILS_DEPENDENCIES := RUST WASI_SDK

COREUTILS_SRC_REV := e477e069d677f7af05fc3fea4f8376bf8d348b72
COREUTILS_SRC_URL := https://github.com/antmicro/coreutils/archive/$(COREUTILS_SRC_REV).zip
COREUTILS_SRC_ZIP := $(BUILD_DIR)/$(COREUTILS_SRC_REV).zip
COREUTILS_SRC_DIR := $(BUILD_DIR)/coreutils-$(COREUTILS_SRC_REV)

COREUTILS_TARGET := $(COREUTILS_SRC_DIR)/target/wasm32-wasi/release/coreutils.wasm
COREUTILS_DIST := $(RESOURCES_DIR)/coreutils

COREUTILS_CARGO_OPTS := --features wasi

$(eval $(call cargo-package,COREUTILS))
