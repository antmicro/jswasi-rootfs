PYTHON_TAG := v0.1.2
PYTHON_URL := https://github.com/antmicro/python-wasi/releases/download/$(PYTHON_TAG)
PYTHON_LIB_URL := https://github.com/antmicro/python-wasi/releases/download/$(PYTHON_TAG)/python.tar.gz

# TODO: integrate python-wasi repository into this package, add packages for wasi_ext_lib and wasix

$(RESOURCES_DIR)/python3: | $(RESOURCES_DIR)
	wget -qO $(RESOURCES_DIR)/python3 $(PYTHON_URL)/python3.wasm

$(RESOURCES_DIR)/python.tar.gz: | $(WORK_DIR) $(RESOURCES_DIR)
	wget -qO $(RESOURCES_DIR)/python.tar.gz $(PYTHON_LIB_URL)

.PHONY: PYTHON
PYTHON: $(RESOURCES_DIR)/python.tar.gz $(RESOURCES_DIR)/python3
