CLANG_REV := 5b36e27758085fa5b11c30de25e4ed80edaf365f
CLANG_URL := https://github.com/wapm-packages/clang/archive/$(CLANG_REV).zip
CLANG_ZIP := $(BUILD_DIR)/clang-$(CLANG_REV).zip
CLANG_DIR := $(BUILD_DIR)/clang-$(CLANG_REV)

CLANG_SYSROOT_TAR := $(CLANG_DIR)/sysroot.tar.gz

CLANG_DIST := $(RESOURCES_DIR)/clang
WASM_LD_DIST := $(RESOURCES_DIR)/wasm-ld
CLANG_SYSROOT_DIST := $(RESOURCES_DIR)/wasi-sysroot.tar.gz

$(CLANG_ZIP): | $(BUILD_DIR)
	@wget -qO $(CLANG_ZIP) $(CLANG_URL)

$(CLANG_DIR): $(CLANG_ZIP) | $(BUILD_DIR)
	@unzip -od $(BUILD_DIR) $(CLANG_ZIP)

$(CLANG_SYSROOT_TAR): $(CLANG_DIR) | $(RESOURCES_DIR)
	tar -czf $(CLANG_SYSROOT_TAR) -C $(CLANG_DIR)/sysroot .

$(CLANG_DIST): $(CLANG_DIR) | $(RESOURCES_DIR)
	@cp $(CLANG_DIR)/clang.wasm $(CLANG_DIST)

$(WASM_LD_DIST): $(CLANG_DIR) | $(RESOURCES_DIR)
	@cp $(CLANG_DIR)/wasm-ld.wasm $(WASM_LD_DIST)

$(CLANG_SYSROOT_DIST): $(CLANG_SYSROOT_TAR) | $(RESOURCES_DIR)
	@cp $(CLANG_SYSROOT_TAR) $(CLANG_SYSROOT_DIST)

.PHONY: CLANG
CLANG: $(CLANG_DIST) $(WASM_LD_DIST) $(CLANG_SYSROOT_DIST)