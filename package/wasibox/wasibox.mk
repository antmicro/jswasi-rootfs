WASIBOX_DEPENDENCIES := RUST WASI_SDK
WASIBOX_PKG_NAME := wasibox

WASIBOX_SRC_REV := 29314c5422c36a638c7e89a1c62fe7bb63274670
WASIBOX_SRC_URL := $(call github_url,antmicro,wasibox,$(WASIBOX_SRC_REV))

WASIBOX_ROOTFS_PATH := /usr/bin/wasibox
WASIBOX_DIST := $(ROOTFS_DIR)$(WASIBOX_ROOTFS_PATH)

WASIBOX_INSTALL_SYMLINKS ?= 1
WASIBOX_APPLETS := imgcat purge tree unzip hexdump kill mount umount stty tar websocat wget mknod uname free ps reset reload

define WASIBOX_INSTALL_CMDS_EXTRA
	if [ "$(WASIBOX_INSTALL_SYMLINKS)" = "1" ]; then \
		for applet in $(WASIBOX_APPLETS); do \
			ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/$$$$applet; \
		done; \
	fi
	mkdir -p $(ROOTFS_DIR)/etc/init.d
endef

$(eval $(call get-sources,WASIBOX))
$(eval $(call cargo-package,WASIBOX))
