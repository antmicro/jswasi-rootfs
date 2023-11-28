JSWASI_SRC_REV := f920e1099017097d57397ff20226d689636d6ffb
JSWASI_SRC_URL := https://github.com/antmicro/jswasi/archive/$(JSWASI_SRC_REV).zip
JSWASI_SRC_ZIP := $(BUILD_DIR)/$(JSWASI_SRC_REV).zip
JSWASI_SRC_DIR := $(BUILD_DIR)/jswasi-$(JSWASI_SRC_REV)

JSWASI_DIST_DIR := $(JSWASI_SRC_DIR)/dist
JSWASI_PATCHES := $(PACKAGE_DIR)/jswasi/init.patch

JSWASI_INDEX := $(PACKAGE_DIR)/jswasi/index.html
JSWASI_INIT := $(PACKAGE_DIR)/jswasi/init.sh
JSWASI_CONFIG := $(PACKAGE_DIR)/jswasi/config.json
JSWASI_VFS_CONFIG := $(PACKAGE_DIR)/jswasi/vfs_config.json

$(JSWASI_SRC_ZIP): | $(BUILD_DIR)
	@wget -qO $(JSWASI_SRC_ZIP) $(JSWASI_SRC_URL)

$(JSWASI_SRC_DIR): $(JSWASI_SRC_ZIP) | $(BUILD_DIR)
	@unzip -od $(BUILD_DIR) $(JSWASI_SRC_ZIP)

$(RESOURCES_DIR)/vfs_config.json: $(JSWASI_VFS_CONFIG) | $(RESOURCES_DIR)
	@cp $(JSWASI_VFS_CONFIG) $(RESOURCES_DIR)/vfs_config.json

$(RESOURCES_DIR)/init.sh: $(JSWASI_INIT) | $(RESOURCES_DIR)
	@cp $(JSWASI_INIT) $(RESOURCES_DIR)/init.sh

$(RESOURCES_DIR)/config.json: $(JSWASI_CONFIG) | $(RESOURCES_DIR)
	@cp $(JSWASI_CONFIG) $(RESOURCES_DIR)/config.json

$(DIST_DIR)/index.html: $(JSWASI_INIT) | $(DIST_DIR)
	@cp $(JSWASI_INDEX) $(DIST_DIR)/index.html

.PHONY: $(JSWASI_DIST_DIR)
$(JSWASI_DIST_DIR): $(JSWASI_SRC_DIR) $(JSWASI_PATCHES)
	@cd $(JSWASI_SRC_DIR) && \
	make embed

.PHONY: JSWASI
JSWASI: $(JSWASI_DIST_DIR) $(RESOURCES_DIR)/init.sh $(RESOURCES_DIR)/config.json $(DIST_DIR)/index.html $(RESOURCES_DIR)/vfs_config.json | $(DIST_DIR)
	@cp -r $(JSWASI_DIST_DIR)/* $(DIST_DIR)

$(eval $(call apply-patches,JSWASI))
