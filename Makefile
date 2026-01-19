INSTALL ?= /usr/bin/install

PACKAGE_DIR ?= $(shell pwd)/package
WORK_DIR ?= $(shell pwd)/work
DIST_DIR ?= $(WORK_DIR)/dist
RESOURCES_DIR ?= $(DIST_DIR)/resources
THIRD_PARTY_DIR ?= $(DIST_DIR)/third_party
BUILD_DIR ?= $(WORK_DIR)/build
ROOTFS_DIR ?= $(WORK_DIR)/rootfs

HTTP_PORT ?= 8000

.DEFAULT_GOAL := build

include ./package/utils.mk
include ./package/get-sources.mk
include ./package/patch-sources.mk
include ./package/cargo-package.mk

define PACKAGE_COMMON
include $(1)/$(notdir $(1)).mk
$(eval PACKAGES_ALL += $(notdir $(1)))

endef

define to_pkg_var
$(subst -,_,$(call uppercase,$(1)))
endef

ALL_PACKAGE_PATHS := $(shell find $(PACKAGE_DIR) $(PACKAGE_EXTERNAL) -maxdepth 2 -mindepth 1 -type d -print)
$(foreach pkg,$(ALL_PACKAGE_PATHS),$(eval $(call PACKAGE_COMMON,$(pkg))))
PACKAGES ?= $(PACKAGES_ALL)
PACKAGES_UPPERCASE := $(foreach pkg,$(PACKAGES),$(call to_pkg_var,$(pkg)))
CLEAN_PACKAGES := $(addprefix clean_pkg_,$(PACKAGES))

.PHONY: build
build: $(RESOURCES_DIR)/rootfs.tar.gz

$(RESOURCES_DIR)/rootfs.tar.gz: $(PACKAGES_UPPERCASE) | $(RESOURCES_DIR)
	cd $(ROOTFS_DIR) && \
	tar -czvf $@ *
	@echo "INFO: Built rootfs archive: $@"

$(WORK_DIR) $(BUILD_DIR) $(DIST_DIR) $(RESOURCES_DIR) $(ROOTFS_DIR) $(THIRD_PARTY_DIR): %:
	mkdir -p $@

.PHONY: run_server
run_server:
	@echo "INFO: Starting jswasi server at http://localhost:$(HTTP_PORT)"
	cd $(DIST_DIR) && python3 -m http.server $(HTTP_PORT)

.PHONY: clean
clean: $(CLEAN_PACKAGES)

$(CLEAN_PACKAGES): clean_pkg_%:
	@echo "INFO: Cleaning package: $*"
	$($(call to_pkg_var,$*)_CLEAN_CMDS)
	$($(call to_pkg_var,$*)_CLEAN_CMDS_EXTRA)

.PHONY: clean_all
clean_all: clean
	rm -rf $(WORK_DIR) $(BUILD_DIR) $(DIST_DIR) $(RESOURCES_DIR) $(ROOTFS_DIR) $(THIRD_PARTY_DIR)

.PHONY: clean_build
clean_build: | $(BUILD_DIR)
	rm -rf $(BUILD_DIR)

.PHONY: clean_dist
clean_dist: | $(DIST_DIR) $(RESOURCES_DIR)
	rm -rf $(DIST_DIR)

.PHONY: clean_resources
clean_resources: | $(RESOURCES_DIR)
	rm -rf $(RESOURCES_DIR)

.PHONY: clean_rootfs
clean_rootfs: | $(ROOTFS_DIR)
	rm -rf $(ROOTFS_DIR)

