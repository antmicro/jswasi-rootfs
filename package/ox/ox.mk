OX_DEPENDENCIES := RUST WASI_SDK
OX_PKG_NAME := ox

OX_SRC_REV := f2fb9c69e8866fc72186ca93cf4ba205ba163672
OX_SRC_URL := $(call github_url,antmicro,ox,$(OX_SRC_REV))

OX_DIST := $(ROOTFS_DIR)/usr/local/bin/ox

define OX_INSTALL_CMDS_EXTRA
	$(INSTALL) -D $(OX_SRC_DIR)/config/ox.ron $(ROOTFS_DIR)/home/ant/.config/ox/ox.ron
endef

$(eval $(call get-sources,OX))
$(eval $(call cargo-package,OX))
