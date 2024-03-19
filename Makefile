INSTALL ?= /usr/bin/install

PACKAGE_DIR ?= $(shell pwd)/package
WORK_DIR ?= $(shell pwd)/work
DIST_DIR ?= $(WORK_DIR)/dist
RESOURCES_DIR ?= $(DIST_DIR)/resources
THIRD_PARTY_DIR ?= $(DIST_DIR)/third_party
BUILD_DIR ?= $(WORK_DIR)/build
ROOTFS_DIR ?= $(WORK_DIR)/rootfs

PACKAGES := rust wasi-sdk coreutils wasibox space-invaders kibi ox wash python jswasi clang

include ./package/utils.mk
include ./package/get-sources.mk
include ./package/patch-sources.mk
include ./package/cargo-package.mk

.PHONY: all
all: $(foreach package,$(PACKAGES),$(subst -,_,$(call uppercase,$(package))))

$(foreach package,$(PACKAGES),$(eval include ./package/$(package)/$(package).mk))

$(WORK_DIR) $(BUILD_DIR) $(DIST_DIR) $(RESOURCES_DIR) $(ROOTFS_DIR) $(THIRD_PARTY_DIR): %:
	mkdir -p $@

.PHONY: clean_all
clean_all: $(clean)
	rm -rf $(WORK_DIR) $(BUILD_DIR) $(DIST_DIR) $(RESOURCES_DIR) $(ROOTFS_DIR) $(THIRD_PARTY_DIR)

.PHONY: clean
clean: | $(BUILD_DIR) $(WORK_DIR) $(DIST_DIR) $(RESOURCES_DIR)
	@rm -rf $(BUILD_DIR)
