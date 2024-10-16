WASH_DEPENDENCIES := RUST WASI_SDK
WASH_PKG_NAME := wash

WASH_SRC_REV := c75120b45e3c2407adf0a4fa6ce92f00b670db70
WASH_SRC_URL := $(call github_url,antmicro,wash,$(WASH_SRC_REV))

WASH_ROOTFS_PATH := /usr/bin/wash
WASH_DIST := $(ROOTFS_DIR)$(WASH_ROOTFS_PATH)

define WASH_INSTALL_CMDS_EXTRA
	$(INSTALL) -D $(PACKAGE_DIR)/wash/wash.service.json $(ROOTFS_DIR)/etc/init.d/wash.service.json
endef  # WASH_INSTALL_CMDS_EXTRA

$(eval $(call get-sources,WASH))
$(eval $(call cargo-package,WASH))
