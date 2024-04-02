PACKAGE_DIR ?= $(shell pwd)/package
WORK_DIR ?= $(shell pwd)/work
DIST_DIR ?= $(WORK_DIR)/dist
RESOURCES_DIR ?= $(DIST_DIR)/resources
THIRD_PARTY_DIR ?= $(DIST_DIR)/third_party
BUILD_DIR := $(WORK_DIR)/build
PACKAGES := rust wasi-sdk coreutils wasibox space-invaders kibi ox wash python jswasi clang

include ./package/utils.mk
include ./package/get-sources.mk
include ./package/patch-sources.mk
include ./package/cargo-package.mk

.PHONY: all
all: $(foreach package,$(PACKAGES),$(subst -,_,$(call uppercase,$(package))))

$(foreach package,$(PACKAGES),$(eval include ./package/$(package)/$(package).mk))

$(WORK_DIR):
	@mkdir -p $(WORK_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(DIST_DIR):
	@mkdir -p $(DIST_DIR)

$(RESOURCES_DIR):
	@mkdir -p $(RESOURCES_DIR)

$(THIRD_PARTY_DIR):
	@mkdir -p $(THIRD_PARTY_DIR)

.PHONY: clean_all
clean_all: $(clean)
	@rm -rf $(WORK_DIR)
	@rm -rf $(DIST_DIR)
	@rm -rf $(RESOURCES_DIR)

.PHONY: clean
clean: | $(BUILD_DIR) $(WORK_DIR) $(DIST_DIR) $(RESOURCES_DIR)
	@rm -rf $(BUILD_DIR)
