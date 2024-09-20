COREUTILS_DEPENDENCIES := RUST WASI_SDK
COREUTILS_PKG_NAME := coreutils

COREUTILS_SRC_REV := e477e069d677f7af05fc3fea4f8376bf8d348b72
COREUTILS_SRC_URL := $(call github_url,antmicro,coreutils,$(COREUTILS_SRC_REV))

COREUTILS_ROOTFS_PATH := /usr/bin/coreutils
COREUTILS_DIST := $(ROOTFS_DIR)$(COREUTILS_ROOTFS_PATH)

COREUTILS_CARGO_OPTS := --features wasi

define COREUTILS_INSTALL_CMDS_EXTRA
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/[
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/cat
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/cp
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/date
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/echo
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/env
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/false
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/head
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/ln
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/ls
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/md5sum
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/mkdir
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/mv
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/printenv
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/realpath
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/rm
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/rmdir
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/seq
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/sleep
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/tail
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/test
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/touch
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/true
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/wc
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/hashsum
	ln -fs $(COREUTILS_ROOTFS_PATH) $(ROOTFS_DIR)/usr/bin/base64
endef

$(eval $(call get-sources,COREUTILS))
$(eval $(call cargo-package,COREUTILS))
