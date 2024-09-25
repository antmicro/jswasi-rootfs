AGE_PKG_NAME := age

AGE_SRC_REV := bbe6ce5eeb1bb70cfc705d0961c943f0dd637ffd
AGE_SRC_URL := $(call github_url,FiloSottile,age,$(AGE_SRC_REV))
AGE_SRC_DIR := $(BUILD_DIR)/age-$(AGE_SRC_REV)

AGE_BUILD_DIR = $(AGE_SRC_DIR)/build
AGE_PATCHES = $(wildcard $(PACKAGE_DIR)/age/*.patch)

$(AGE_BUILD_DIR): | $(AGE_SRC_DIR)
	mkdir -p $@

.PHONY: $(AGE_BUILD_DIR)/age
$(AGE_BUILD_DIR)/age: AGE_PATCH | $(AGE_BUILD_DIR)
	cd $(AGE_SRC_DIR) && GO111MODULE=on GOOS="wasip1" GOARCH="wasm" go build -o $(AGE_BUILD_DIR) ./cmd/age

.PHONY: $(AGE_BUILD_DIR)/age-keygen
$(AGE_BUILD_DIR)/age-keygen: AGE_PATCH | $(AGE_BUILD_DIR)
	cd $(AGE_SRC_DIR) && GO111MODULE=on GOOS="wasip1" GOARCH="wasm" go build -o $(AGE_BUILD_DIR) ./cmd/age-keygen

$(AGE_SRC_DIR)/.installed: | $(AGE_BUILD_DIR)/age $(AGE_BUILD_DIR)/age-keygen $(AGE_DEPENDENCIES) $(ROOTFS_DIR)
	$(INSTALL) -D $(AGE_BUILD_DIR)/age $(ROOTFS_DIR)/usr/bin/age
	$(INSTALL) -D $(AGE_BUILD_DIR)/age-keygen $(ROOTFS_DIR)/usr/bin/age-keygen

.PHONY: AGE
AGE: $(AGE_SRC_DIR)/.installed

$(eval $(call get-sources,AGE))
$(eval $(call apply-patches,AGE))
