WASIBOX_DEPENDENCIES := RUST WASI_SDK
WASIBOX_PKG_NAME := wasibox

WASIBOX_SRC_REV := ea5d990e9ed19f3756af006632264c9f1e15a298
WASIBOX_SRC_URL := $(call github_url,antmicro,wasibox,$(WASIBOX_SRC_REV))

WASIBOX_ROOTFS_PATH := /usr/bin/wasibox
WASIBOX_DIST := $(ROOTFS_DIR)$(WASIBOX_ROOTFS_PATH)

define WASIBOX_INSTALL_CMDS_EXTRA
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/imgcat
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/purge
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/tree
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/unzip
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/hexdump
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/kill
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/mount
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/umount
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/stty
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/tar
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/wget
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/mknod
endef

$(eval $(call get-sources,WASIBOX))
$(eval $(call cargo-package,WASIBOX))