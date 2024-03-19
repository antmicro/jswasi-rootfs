JSWASI_DEPENDENCIES := RUST WASI_SDK
JSWASI_PKG_NAME := jswasi

JSWASI_SRC_REV := b6244b5a594fb78d17981951a84cd8f62b4653bd
JSWASI_SRC_URL := $(call github_url,antmicro,jswasi,$(JSWASI_SRC_REV))

JSWASI_DIST_DIR = $(JSWASI_SRC_DIR)/dist

JSWASI_PATCHES := $(PACKAGE_DIR)/jswasi/init.patch

JSWASI_INIT := $(PACKAGE_DIR)/jswasi/init.sh
JSWASI_CONFIG := $(PACKAGE_DIR)/jswasi/config.json
JSWASI_VFS_CONFIG := $(PACKAGE_DIR)/jswasi/vfs_config.json

JSWASI_INDEX = $(JSWASI_DIST_DIR)/index.html
JSWASI_MOTD = $(JSWASI_DIST_DIR)/resources/motd.txt
JSWASI_HTERM = $(JSWASI_DIST_DIR)/third_party/hterm_all.js

JSWASI_SYSCALLS_TEST_TARGET = $(JSWASI_SRC_DIR)/tests/syscalls/target/wasm32-wasi/release/syscalls_test.wasm
JSWASI_SYSCALLS_TEST_DIST := $(RESOURCES_DIR)/syscalls_test


$(eval $(call get-sources,JSWASI))
$(eval $(call apply-patches,JSWASI))


$(RESOURCES_DIR)/%: $(PACKAGE_DIR)/jswasi/% | $(RESOURCES_DIR)
	cp $< $@

$(JSWASI_SYSCALLS_TEST_TARGET): $(JSWASI_SRC_DIR)
	CC="$(WASI_SDK_PATH)/bin/clang" $(CARGO) build --manifest-path $(JSWASI_SRC_DIR)/tests/syscalls/Cargo.toml --target wasm32-wasi --release

$(JSWASI_SYSCALLS_TEST_DIST): $(JSWASI_SYSCALLS_TEST_TARGET) | $(RESOURCES_DIR)
	cp $(JSWASI_SYSCALLS_TEST_TARGET) $(JSWASI_SYSCALLS_TEST_DIST)

.PHONY: $(JSWASI_DIST_DIR)
$(JSWASI_DIST_DIR): $(JSWASI_SRC_DIR) $(JSWASI_PATCHES)
	cd $(JSWASI_SRC_DIR) && \
	make MINIFY=$(JSWASI_MINIFY) embed

$(JSWASI_MOTD) $(JSWASI_INDEX) $(JSWASI_HTERM): %: $(JSWASI_DIST_DIR)
	cd $(JSWASI_SRC_DIR) && \
	make MINIFY=$(JSWASI_MINIFY) $@

$(RESOURCES_DIR)/motd.txt: $(JSWASI_MOTD) | $(RESOURCES_DIR)
	cp $< $@

$(DIST_DIR)/index.html: $(JSWASI_INDEX) | $(DIST_DIR)
	cp $< $@

$(THIRD_PARTY_DIR)/hterm_all.js: $(JSWASI_HTERM) | $(THIRD_PARTY_DIR)
	cp $< $@

$(JSWASI_SRC_DIR)/.installed: $(RESOURCES_DIR)/motd.txt $(THIRD_PARTY_DIR)/hterm_all.js $(RESOURCES_DIR)/init.sh $(RESOURCES_DIR)/config.json $(DIST_DIR)/index.html $(RESOURCES_DIR)/vfs_config.json $(JSWASI_SYSCALLS_TEST_DIST) | $(DIST_DIR) $(ROOTFS_DIR) $(RESOURCES_DIR) $(JSWASI_DEPENENCIES) $(JSWASI_DIST_DIR)
	cp -r $(JSWASI_DIST_DIR)/* $(DIST_DIR)
	$(INSTALL) -D $(JSWASI_INIT) $(ROOTFS_DIR)/usr/bin/init.sh
	$(INSTALL) -D $(JSWASI_MOTD) $(ROOTFS_DIR)/etc/motd
	mkdir -p $(ROOTFS_DIR)/tmp $(ROOTFS_DIR)/mnt $(ROOTFS_DIR)/proc $(ROOTFS_DIR)/dev
	touch $(JSWASI_SRC_DIR)/.installed

.PHONY: JSWASI
JSWASI: $(JSWASI_SRC_DIR)/.installed

.PHONY: JSWASI_CLEAN
JSWASI_CLEAN:
	cd $(JSWASI_SRC_DIR) && \
	make clean-all

.PHONY: JSWASI_RUN_TESTS
JSWASI_RUN_TESTS: $(JSWASI_SRC_DIR)
	cd $(JSWASI_SRC_DIR) && \
	make test
