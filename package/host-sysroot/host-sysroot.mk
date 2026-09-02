# host-sysroot package is used to combine the WASI SDK sysroot with all other built libraries and headers
# to create a complete sysroot for the compilation of subsequent packages.
HOST_SYSROOT_DEPENDENCIES := WASI_SDK
HOST_SYSROOT_PKG_NAME := host-sysroot

# Common HOST_SYSROOT definitions
HOST_SYSROOT_DIR = $(WORK_DIR)/host-sysroot
HOST_SYSROOT_LIB = $(HOST_SYSROOT_DIR)/lib/$(WASI_TARGET)
HOST_SYSROOT_INC = $(HOST_SYSROOT_DIR)/include/$(WASI_TARGET)
HOST_SYSROOT_THREADS_LIB = $(HOST_SYSROOT_DIR)/lib/$(WASI_TARGET_THREADS)
HOST_SYSROOT_THREADS_INC = $(HOST_SYSROOT_DIR)/include/$(WASI_TARGET_THREADS)

$(HOST_SYSROOT_DIR)/.initialized: | $(WASI_SDK_SRC_DIR) $(WORK_DIR)

	@echo "INFO: Initializing sysroot from WASI SDK..."
	rm -rf $(HOST_SYSROOT_DIR)
	mkdir -p $(HOST_SYSROOT_DIR)
	mkdir -p $(HOST_SYSROOT_LIB) $(HOST_SYSROOT_INC) $(HOST_SYSROOT_THREADS_LIB) $(HOST_SYSROOT_THREADS_INC)
	cp -r $(WASI_SDK_SYSROOT)/* $(HOST_SYSROOT_DIR)/

	touch $@

.PHONY: HOST_SYSROOT
HOST_SYSROOT: $(HOST_SYSROOT_DIR)/.initialized

define HOST_SYSROOT_CLEAN_CMDS_EXTRA
	rm -rf $(HOST_SYSROOT_DIR)
endef
