WASI_SDK_VERSION := 33
WASI_SDK_VERSION_FULL := $(WASI_SDK_VERSION).0
WASI_SDK_SRC_TAR := $(BUILD_DIR)/wasi-sdk-$(WASI_SDK_VERSION_FULL)-x86_64-linux.tar.gz
WASI_SDK_SRC_DIR := $(BUILD_DIR)/wasi-sdk-$(WASI_SDK_VERSION_FULL)
WASI_SDK_PATH = $(WASI_SDK_SRC_DIR)

# Common WASI_SDK toolchain binary definitions
WASI_SDK_CLANG ?= $(WASI_SDK_PATH)/bin/clang
WASI_SDK_AR ?= $(WASI_SDK_PATH)/bin/llvm-ar
WASI_SDK_RANLIB ?= $(WASI_SDK_PATH)/bin/llvm-ranlib
WASI_SDK_SYSROOT ?= $(WASI_SDK_PATH)/share/wasi-sysroot

$(WASI_SDK_SRC_TAR): | $(BUILD_DIR)
	wget -qO $(WASI_SDK_SRC_TAR) https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-$(WASI_SDK_VERSION)/wasi-sdk-$(WASI_SDK_VERSION_FULL)-x86_64-linux.tar.gz
	touch $(WASI_SDK_SRC_TAR)

$(WASI_SDK_SRC_DIR): $(WASI_SDK_SRC_TAR)
	mkdir -p $(WASI_SDK_PATH) && \
	tar --strip-components 1 -xf $(WASI_SDK_SRC_TAR) -C $(WASI_SDK_PATH) && \
	touch $(WASI_SDK_SRC_DIR) || \
	rm -rf $(WASI_SDK_PATH)

.PHONY: WASI_SDK
WASI_SDK: $(WASI_SDK_SRC_DIR)

define WASI_SDK_CLEAN_CMDS_EXTRA
	rm -rf $(WASI_SDK_SRC_DIR)
	rm -f $(WASI_SDK_SRC_TAR)
endef
