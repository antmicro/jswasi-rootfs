# sysroot package is used to combine the WASI SDK sysroot with all other built libraries and headers
# to create a complete sysroot for the compilation of subsequent packages.
SYSROOT_DEPENDENCIES := WASI_SDK
SYSROOT_PKG_NAME := sysroot

# Common SYSROOT definitions
SYSROOT_DIR ?= $(WORK_DIR)/sysroot
SYSROOT_LIB ?= $(HOST_SYSROOT_DIR)/lib/$(WASI_TARGET)
SYSROOT_INC ?= $(HOST_SYSROOT_DIR)/include/$(WASI_TARGET)
SYSROOT_THREADS_LIB ?= $(HOST_SYSROOT_DIR)/lib/$(WASI_TARGET_THREADS)
SYSROOT_THREADS_INC ?= $(HOST_SYSROOT_DIR)/include/$(WASI_TARGET_THREADS)

$(SYSROOT_DIR)/.initialized: | $(WASI_SDK_SRC_DIR) $(WORK_DIR)

	@echo "INFO: Initializing sysroot from WASI SDK..."
	rm -rf $(SYSROOT_DIR)
	mkdir -p $(SYSROOT_DIR)
	mkdir -p $(SYSROOT_LIB) $(SYSROOT_INC)
	cp -r $(WASI_SDK_SYSROOT)/* $(SYSROOT_DIR)/

	touch $@

.PHONY: SYSROOT
SYSROOT: $(SYSROOT_DIR)/.initialized

define SYSROOT_CLEAN_CMDS_EXTRA
	rm -rf $(SYSROOT_DIR)
endef
