SPACE_INVADERS_DEPENDENCIES := RUST WASI_SDK
SPACE_INVADERS_PKG_NAME := space-invaders

SPACE_INVADERS_SRC_REV := d5fdeb2d0cf38d9cdfdabcdbc4be3d9ad29e68cd
SPACE_INVADERS_SRC_URL := $(call github_url,mia1024,space-invaders,$(SPACE_INVADERS_SRC_REV))

SPACE_INVADERS_DIST := $(ROOTFS_DIR)/usr/local/bin/space-invaders

SPACE_INVADERS_PATCHES := $(wildcard $(PACKAGE_DIR)/space-invaders/*.patch)

define SPACE_INVADERS_SRC_DIR_CMDS
	@unzip -od $(BUILD_DIR) $(SPACE_INVADERS_SRC_ZIP)
	@rm $(SPACE_INVADERS_SRC_DIR)/Cargo.lock
endef

define SPACE_INVADERS_INSTALL_CMDS_EXTRA
	$(INSTALL) -D $(PACKAGE_DIR)/space-invaders/config.ini $(ROOTFS_DIR)/etc/space-invaders/config.ini
endef

$(eval $(call get-sources,SPACE_INVADERS))
$(eval $(call apply-patches,SPACE_INVADERS))
$(eval $(call cargo-package,SPACE_INVADERS))
