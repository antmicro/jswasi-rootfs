PYTHON_TAG := v0.1.3
PYTHON_URL := https://github.com/antmicro/python-wasi/releases/download/$(PYTHON_TAG)
PYTHON_LIB_URL := https://github.com/antmicro/python-wasi/releases/download/$(PYTHON_TAG)/python.tar.gz

PYTHON_BUILD_DIR := $(BUILD_DIR)/python-wasi-$(PYTHON_TAG)
# TODO: integrate python-wasi repository into this package, add packages for wasi_ext_lib and wasix

$(PYTHON_BUILD_DIR): | $(BUILD_DIR)
	mkdir -p $@

$(PYTHON_BUILD_DIR)/python: | $(PYTHON_BUILD_DIR)
	wget -qO $@ $(PYTHON_URL)/python3.wasm
	wasm-strip $@

$(PYTHON_BUILD_DIR)/python.tar.gz: | $(WORK_DIR) $(PYTHON_BUILD_DIR)
	wget -qO $(PYTHON_BUILD_DIR)/python.tar.gz $(PYTHON_LIB_URL)

$(PYTHON_BUILD_DIR)/.installed: $(PYTHON_BUILD_DIR)/python.tar.gz $(PYTHON_BUILD_DIR)/python
	$(INSTALL) -D $(PYTHON_BUILD_DIR)/python $(ROOTFS_DIR)/usr/bin/python
	mkdir -p $(ROOTFS_DIR)/lib
	tar -xvf $(PYTHON_BUILD_DIR)/python.tar.gz -C $(ROOTFS_DIR)/lib
	touch $@

.PHONY: PYTHON
PYTHON: $(PYTHON_BUILD_DIR)/.installed
