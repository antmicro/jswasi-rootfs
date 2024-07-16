WASH_DEPENDENCIES := RUST WASI_SDK
WASH_PKG_NAME := wash

WASH_SRC_REV := 225ead9ea183987041b1a901057dd4afd8b4f829
WASH_SRC_URL := $(call github_url,antmicro,wash,$(WASH_SRC_REV))

WASH_ROOTFS_PATH := /usr/bin/wash
WASH_DIST := $(ROOTFS_DIR)$(WASH_ROOTFS_PATH)

$(eval $(call get-sources,WASH))
$(eval $(call cargo-package,WASH))
