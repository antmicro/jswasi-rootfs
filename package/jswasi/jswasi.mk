JSWASI_DEPENDENCIES := RUST WASI_SDK
JSWASI_PKG_NAME := jswasi

JSWASI_SRC_REV := 63eb49bc5c82281bd96cb6e4b124b170c76ffd41
JSWASI_SRC_URL := $(call github_url,antmicro,jswasi,$(JSWASI_SRC_REV))

JSWASI_DIST_DIR = $(JSWASI_SRC_DIR)/dist

JSWASI_PATCHES := $(PACKAGE_DIR)/jswasi/init.patch

JSWASI_CONFIG := $(PACKAGE_DIR)/jswasi/config.json
JSWASI_VFS_CONFIG := $(PACKAGE_DIR)/jswasi/vfs_config.json

JSWASI_INDEX = $(JSWASI_DIST_DIR)/index.html
JSWASI_MOTD = $(JSWASI_DIST_DIR)/resources/motd.txt
JSWASI_HTERM = $(JSWASI_DIST_DIR)/third_party/hterm.js

JSWASI_SYSCALLS_TEST_TARGET = $(JSWASI_SRC_DIR)/tests/syscalls/target/wasm32-wasi/release/syscalls_test.wasm
JSWASI_SYSCALLS_TEST_DIST := $(RESOURCES_DIR)/syscalls_test


$(eval $(call get-sources,JSWASI))
$(eval $(call apply-patches,JSWASI))


$(RESOURCES_DIR)/%: $(PACKAGE_DIR)/jswasi/% | $(RESOURCES_DIR)
	cp $< $@

$(JSWASI_SYSCALLS_TEST_TARGET): $(JSWASI_SRC_DIR)
	CC="$(WASI_SDK_PATH)/bin/clang" $(CARGO) build --manifest-path $(JSWASI_SRC_DIR)/tests/syscalls/Cargo.toml --target wasm32-wasi --release
	wasm-strip $@

$(JSWASI_SYSCALLS_TEST_DIST): $(JSWASI_SYSCALLS_TEST_TARGET) | $(RESOURCES_DIR)
	cp $(JSWASI_SYSCALLS_TEST_TARGET) $(JSWASI_SYSCALLS_TEST_DIST)

.PHONY: $(JSWASI_DIST_DIR)
$(JSWASI_DIST_DIR): $(JSWASI_SRC_DIR) $(JSWASI_SRC_DIR)/.patched
	cd $(JSWASI_SRC_DIR) && \
	make MINIFY=$(JSWASI_MINIFY) embed

$(JSWASI_MOTD) $(JSWASI_INDEX) $(JSWASI_HTERM): %: $(JSWASI_DIST_DIR)
	cd $(JSWASI_SRC_DIR) && \
	make MINIFY=$(JSWASI_MINIFY) $@

$(DIST_DIR)/index.html: $(JSWASI_INDEX) | $(DIST_DIR)
	cp $< $@

$(THIRD_PARTY_DIR)/hterm.js: $(JSWASI_HTERM) | $(THIRD_PARTY_DIR)
	cp $< $@

$(JSWASI_SRC_DIR)/.installed: $(JSWASI_MOTD) $(THIRD_PARTY_DIR)/hterm.js $(RESOURCES_DIR)/config.json $(DIST_DIR)/index.html $(RESOURCES_DIR)/vfs_config.json $(JSWASI_SYSCALLS_TEST_DIST) | $(DIST_DIR) $(ROOTFS_DIR) $(RESOURCES_DIR) $(JSWASI_DEPENENCIES) $(JSWASI_DIST_DIR)
	cp -r $(JSWASI_DIST_DIR)/* $(DIST_DIR)
	$(INSTALL) -D $(JSWASI_MOTD) $(ROOTFS_DIR)/etc/motd
	mkdir -p $(ROOTFS_DIR)/tmp $(ROOTFS_DIR)/mnt $(ROOTFS_DIR)/proc $(ROOTFS_DIR)/dev
	# Browser apps
	touch $(ROOTFS_DIR)/usr/bin/ps
	touch $(ROOTFS_DIR)/usr/bin/free
	touch $(ROOTFS_DIR)/usr/bin/reset
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
