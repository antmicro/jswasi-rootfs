JSWASI_DEPENDENCIES := RUST WASI_SDK
JSWASI_PKG_NAME := jswasi

JSWASI_SRC_REV := 6a4ec447d791b2dd705e1099c63b96ae18912d28
JSWASI_SRC_URL := $(call github_url,antmicro,jswasi,$(JSWASI_SRC_REV))

JSWASI_DIST_DIR = $(JSWASI_SRC_DIR)/dist

JSWASI_PATCHES := $(PACKAGE_DIR)/jswasi/init.patch

JSWASI_INDEX := $(PACKAGE_DIR)/jswasi/index.html
JSWASI_INIT := $(PACKAGE_DIR)/jswasi/init.sh
JSWASI_CONFIG := $(PACKAGE_DIR)/jswasi/config.json
JSWASI_VFS_CONFIG := $(PACKAGE_DIR)/jswasi/vfs_config.json

JSWASI_MOTD = $(JSWASI_DIST_DIR)/resources/motd.txt

JSWASI_SYSCALLS_TEST_TARGET = $(JSWASI_SRC_DIR)/tests/syscalls/target/wasm32-wasi/release/syscalls_test.wasm
JSWASI_SYSCALLS_TEST_DIST := $(RESOURCES_DIR)/syscalls_test


$(eval $(call get-sources,JSWASI))
$(eval $(call apply-patches,JSWASI))


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

$(JSWASI_MOTD): $(JSWASI_DIST_DIR)
	@cd $(JSWASI_SRC_DIR) && \
	make $(JSWASI_MOTD)

$(RESOURCES_DIR)/motd.txt: $(JSWASI_MOTD) | $(RESOURCES_DIR)
	@cp $(JSWASI_MOTD) $(RESOURCES_DIR)/motd.txt

.PHONY: JSWASI
JSWASI: $(JSWASI_DIST_DIR) $(RESOURCES_DIR)/motd.txt $(RESOURCES_DIR)/init.sh $(RESOURCES_DIR)/config.json $(DIST_DIR)/index.html $(RESOURCES_DIR)/vfs_config.json $(JSWASI_SYSCALLS_TEST_DIST) | $(DIST_DIR)
	@cp -r $(JSWASI_DIST_DIR)/* $(DIST_DIR)

.PHONY: JSWASI_RUN_TESTS
JSWASI_RUN_TESTS: $(JSWASI_SRC_DIR)
	@cd $(JSWASI_SRC_DIR) && \
	make test
