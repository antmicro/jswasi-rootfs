WASI_SDK_VERSION := 16
WASI_SDK_VERSION_FULL := $(WASI_SDK_VERSION).0
WASI_SDK_SRC_TAR := $(BUILD_DIR)/wasi-sdk-$(WASI_SDK_VERSION_FULL)-linux.tar.gz
WASI_SDK_SRC_DIR := $(BUILD_DIR)/wasi-sdk-$(WASI_SDK_VERSION_FULL)
WASI_SDK_PATH = $(WASI_SDK_SRC_DIR)

$(WASI_SDK_SRC_TAR): | $(BUILD_DIR)
	@wget -qO $(WASI_SDK_SRC_TAR) https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-$(WASI_SDK_VERSION)/wasi-sdk-$(WASI_SDK_VERSION_FULL)-linux.tar.gz
	@touch $(WASI_SDK_SRC_TAR)

$(WASI_SDK_SRC_DIR): $(WASI_SDK_SRC_TAR)
	@tar -xf $(WASI_SDK_SRC_TAR) -C $(BUILD_DIR)
	@touch $(WASI_SDK_SRC_DIR)

.PHONY: WASI_SDK
WASI_SDK: $(WASI_SDK_SRC_DIR)
