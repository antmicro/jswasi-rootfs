OX_DEPENDENCIES := RUST WASI_SDK
OX_PKG_NAME := ox

OX_SRC_REV := ff1fbd2b9947f69b2f8f4d63b62ebbfc801c38bf
OX_SRC_URL := $(call github_url,antmicro,ox,$(OX_SRC_REV))

OX_DIST := $(ROOTFS_DIR)/usr/local/bin/ox

define OX_INSTALL_CMDS_EXTRA
	$(INSTALL) -D $(OX_SRC_DIR)/config/ox.ron $(ROOTFS_DIR)/home/ant/.config/ox.ron
endef

$(eval $(call get-sources,OX))
$(eval $(call cargo-package,OX))
