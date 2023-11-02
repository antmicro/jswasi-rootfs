PACKAGE_DIR ?= $(shell pwd)/package
WORK_DIR ?= $(shell pwd)/work
DIST_DIR ?= $(WORK_DIR)/dist
RESOURCES_DIR ?= $(DIST_DIR)/resources
BUILD_DIR := $(WORK_DIR)/build

PACKAGES := rust wasi-sdk coreutils

include ./package/patch-sources.mk
include ./package/cargo-package.mk

$(foreach package,$(PACKAGES),$(eval include ./package/$(package)/$(package).mk))

$(WORK_DIR):
	@mkdir -p $(WORK_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(DIST_DIR):
	@mkdir -p $(DIST_DIR)

$(RESOURCES_DIR):
	@mkdir -p $(RESOURCES_DIR)

.PHONY: all
all: $(foreach package,$(PACKAGES),$(shell echo $(package) | tr [:lower:] [:upper:] | tr '-' '_'))

.PHONY: clean
clean: | $(BUILD_DIR) $(WORK_DIR) $(DIST_DIR) $(RESOURCES_DIR)
	@rm -rf $(BUILD_DIR)
	@rm -rf $(WORK_DIR)
	@rm -rf $(DIST_DIR)
	@rm -rf $(RESOURCES_DIR)
