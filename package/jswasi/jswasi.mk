JSWASI_DEPENDENCIES := RUST WASI_SDK

JSWASI_SRC_REV := 01b4cead721ed0f1c755a8bae88bdc155aa0309d
JSWASI_SRC_URL := https://github.com/antmicro/jswasi/archive/$(JSWASI_SRC_REV).zip
JSWASI_SRC_ZIP := $(BUILD_DIR)/$(JSWASI_SRC_REV).zip

JSWASI_SRC_DIR := $(BUILD_DIR)/jswasi-$(JSWASI_SRC_REV)

JSWASI_DIST_DIR := $(JSWASI_SRC_DIR)/dist
JSWASI_PATCHES := $(PACKAGE_DIR)/jswasi/init.patch

JSWASI_INDEX := $(PACKAGE_DIR)/jswasi/index.html
JSWASI_INIT := $(PACKAGE_DIR)/jswasi/init.sh
JSWASI_CONFIG := $(PACKAGE_DIR)/jswasi/config.json
JSWASI_VFS_CONFIG := $(PACKAGE_DIR)/jswasi/vfs_config.json

JSWASI_SYSCALLS_TEST_TARGET := $(JSWASI_SRC_DIR)/tests/syscalls/target/wasm32-wasi/release/syscalls_test.wasm
JSWASI_SYSCALLS_TEST_DIST := $(RESOURCES_DIR)/syscalls_test

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

$(JSWASI_SYSCALLS_TEST_TARGET): $(JSWASI_SRC_DIR)
	@CC="$(WASI_SDK_PATH)/bin/clang" $(CARGO) build --manifest-path $(JSWASI_SRC_DIR)/tests/syscalls/Cargo.toml --target wasm32-wasi --release

$(JSWASI_SYSCALLS_TEST_DIST): $(JSWASI_SYSCALLS_TEST_TARGET) | $(RESOURCES_DIR)
	@cp $(JSWASI_SYSCALLS_TEST_TARGET) $(JSWASI_SYSCALLS_TEST_DIST)

.PHONY: $(JSWASI_DIST_DIR)
$(JSWASI_DIST_DIR): $(JSWASI_SRC_DIR) $(JSWASI_PATCHES)
	@cd $(JSWASI_SRC_DIR) && \
	make embed

.PHONY: JSWASI
JSWASI: $(JSWASI_DIST_DIR) $(RESOURCES_DIR)/init.sh $(RESOURCES_DIR)/config.json $(DIST_DIR)/index.html $(RESOURCES_DIR)/vfs_config.json $(JSWASI_SYSCALLS_TEST_DIST) | $(DIST_DIR)
	@cp -r $(JSWASI_DIST_DIR)/* $(DIST_DIR)

.PHONY: JSWASI_RUN_TESTS
JSWASI_RUN_TESTS: $(JSWASI_DIST_DIR)
	@cd $(JSWASI_SRC_DIR) && \
	npm run test:unit

$(eval $(call apply-patches,JSWASI))
