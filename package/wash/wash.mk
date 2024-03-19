WASH_DEPENDENCIES := RUST WASI_SDK
WASH_PKG_NAME := wash

WASH_SRC_REV := a4563d213ffa37516178b3578bb77e26d3bbf0f9
WASH_SRC_URL := $(call github_url,antmicro,wash,$(WASH_SRC_REV))

WASH_ROOTFS_PATH := /usr/bin/wash
WASH_DIST := $(ROOTFS_DIR)$(WASH_ROOTFS_PATH)

$(eval $(call get-sources,WASH))
$(eval $(call cargo-package,WASH))
