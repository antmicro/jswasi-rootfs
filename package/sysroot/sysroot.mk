SYSROOT_DEPENDENCIES := WASI_SDK
SYSROOT_PKG_NAME := sysroot

$(SYSROOT_DIR)/.initialized: | $(WASI_SDK_SRC_DIR) $(WORK_DIR)

	@echo "INFO: Initializing sysroot from WASI SDK..."
	rm -rf $(SYSROOT_DIR)
	mkdir -p $(SYSROOT_DIR)
	cp -r $(WASI_SDK_SYSROOT)/* $(SYSROOT_DIR)/

	touch $@

.PHONY: SYSROOT
SYSROOT: $(SYSROOT_DIR)/.initialized

define SYSROOT_CLEAN_CMDS_EXTRA
	rm -rf $(SYSROOT_DIR)
endef
