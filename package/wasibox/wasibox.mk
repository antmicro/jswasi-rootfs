WASIBOX_DEPENDENCIES := RUST WASI_SDK
WASIBOX_PKG_NAME := wasibox

WASIBOX_SRC_REV := 9bf32e0504990214b22b57f4e9d7e4abf1a0ca97
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
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/websocat
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/wget
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/mknod
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/uname
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/free
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/ps
	ln -fs $(WASIBOX_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/reset

	mkdir -p $(ROOTFS_DIR)/etc/init.d
endef

$(eval $(call get-sources,WASIBOX))
$(eval $(call cargo-package,WASIBOX))
