KIBI_DEPENDENCIES := RUST WASI_SDK

KIBI_SRC_REV := 7b1e1068813875242b2c8c230d6fb71fd5b4b4d5
KIBI_SRC_URL := https://github.com/antmicro/kibi/archive/$(KIBI_SRC_REV).zip
KIBI_SRC_ZIP := $(BUILD_DIR)/$(KIBI_SRC_REV).zip
KIBI_SRC_DIR := $(BUILD_DIR)/kibi-$(KIBI_SRC_REV)

KIBI_TARGET := $(KIBI_SRC_DIR)/target/wasm32-wasi/release/kibi.wasm
KIBI_DIST := $(RESOURCES_DIR)/kibi
KIBI_DIST_EXTRA := $(RESOURCES_DIR)/syntax.d.zip

KIBI_PATCHES := $(wildcard $(PACKAGE_DIR)/kibi/*.patch)

$(RESOURCES_DIR)/syntax.d.zip: $(KIBI_SRC_DIR)/syntax.d
	@cd $(KIBI_SRC_DIR) && \
	zip -r $(RESOURCES_DIR)/syntax.d.zip syntax.d

$(eval $(call cargo-package,KIBI))
