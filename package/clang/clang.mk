CLANG_PKG_NAME := clang

CLANG_SRC_REV := 5b36e27758085fa5b11c30de25e4ed80edaf365f
CLANG_SRC_URL := $(call github_url,wapm-packages,clang,$(CLANG_SRC_REV))

CLANG_DIST := $(ROOTFS_DIR)/usr/bin/clang
WASM_LD_DIST := $(RESOURCES_DIR)/usr/bin/wasm-ld


$(eval $(call get-sources,CLANG))

$(CLANG_DIST): $(CLANG_SRC_DIR) | $(RESOURCES_DIR)
	$(INSTALL) -D $(CLANG_SRC_DIR)/clang.wasm $(CLANG_DIST)

$(WASM_LD_DIST): $(CLANG_SRC_DIR) | $(RESOURCES_DIR)
	$(INSTALL) -D $(CLANG_SRC_DIR)/wasm-ld.wasm $(WASM_LD_DIST)

$(CLANG_SYSROOT_DIST): $(CLANG_SYSROOT_TAR) | $(RESOURCES_DIR)
	@cp $(CLANG_SYSROOT_TAR) $(CLANG_SYSROOT_DIST)

$(CLANG_SRC_DIR)/.installed: $(CLANG_DIST) $(WASM_LD_DIST) $(CLANG_SYSROOT_DIST) | $(ROOTFS_DIR)
	$(INSTALL) -D $(CLANG_SRC_DIR)/clang.wasm $(CLANG_DIST)
	$(INSTALL) -D $(CLANG_SRC_DIR)/wasm-ld.wasm $(WASM_LD_DIST)
	cp -r $(CLANG_SRC_DIR)/sysroot/* $(ROOTFS_DIR)
	touch $@

.PHONY: CLANG
CLANG: $(CLANG_SRC_DIR)/.installed
