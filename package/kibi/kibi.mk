KIBI_DEPENDENCIES := RUST WASI_SDK
KIBI_PKG_NAME := kibi

KIBI_SRC_REV := 7b1e1068813875242b2c8c230d6fb71fd5b4b4d5
KIBI_SRC_URL := $(call github_url,antmicro,kibi,$(KIBI_SRC_REV))

KIBI_DIST := $(ROOTFS_DIR)/usr/local/bin/kibi

KIBI_PATCHES := $(wildcard $(PACKAGE_DIR)/kibi/*.patch)

define KIBI_INSTALL_CMDS_EXTRA
	mkdir -p $(ROOTFS_DIR)/home/ant/.config/kibi
	cp -r $(KIBI_SRC_DIR)/syntax.d $(ROOTFS_DIR)/home/ant/.config/kibi/syntax.d
endef

$(eval $(call get-sources,KIBI))
$(eval $(call cargo-package,KIBI))
