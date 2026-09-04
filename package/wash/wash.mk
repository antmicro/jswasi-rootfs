WASH_DEPENDENCIES := RUST WASI_SDK
WASH_PKG_NAME := wash

WASH_SRC_REV := 3066e4317d8fcb58d2a31b63cf62eae14266aa0f
WASH_SRC_URL := $(call github_url,antmicro,wash,$(WASH_SRC_REV))

WASH_ROOTFS_PATH := /usr/bin/wash
WASH_DIST := $(ROOTFS_DIR)$(WASH_ROOTFS_PATH)

WASH_INSTALL_INIT_SERVICE ?= 1

define WASH_INSTALL_CMDS_EXTRA
	if [ "$(WASH_INSTALL_INIT_SERVICE)" = "1" ]; then $(INSTALL) -D $(WASH_PKG_DIR)/wash.service.json $(ROOTFS_DIR)/etc/init.d/wash.service.json; fi
endef

$(eval $(call get-sources,WASH))
$(eval $(call cargo-package,WASH))
