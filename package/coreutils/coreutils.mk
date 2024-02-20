COREUTILS_DEPENDENCIES := RUST WASI_SDK
COREUTILS_PKG_NAME := coreutils

COREUTILS_SRC_REV := e477e069d677f7af05fc3fea4f8376bf8d348b72
COREUTILS_SRC_URL := $(call github_url,antmicro,coreutils,$(COREUTILS_SRC_REV))

COREUTILS_TARGET = $(COREUTILS_SRC_DIR)/target/wasm32-wasi/release/coreutils.wasm
COREUTILS_DIST := $(RESOURCES_DIR)/coreutils

COREUTILS_CARGO_OPTS := --features wasi

$(eval $(call get-sources,COREUTILS))
$(eval $(call cargo-package,COREUTILS))
