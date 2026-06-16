PYTHON_DEPENDENCIES := WASI_SDK
PYTHON_PKG_NAME := python

PYTHON_SRC_REV := v3.14.5
PYTHON_SRC_URL := $(call github_url,python,cpython,$(PYTHON_SRC_REV))

PYTHON_TAG := v3.14.5
PYTHON_VERSION_NOPATCH := 3.14

PYTHON_BUILD_DIR = $(BUILD_DIR)/python-$(PYTHON_TAG)
PYTHON_BUILD = $(PYTHON_BUILD_DIR)/python

PYTHON_PATCHES = $(wildcard $(PACKAGE_DIR)/python/*.patch)

GNU_BUILD_PATH = $(PYTHON_SRC_DIR)/cross-build/x86_64-pc-linux-gnu
TARGET_BUILD_PATH = $(PYTHON_SRC_DIR)/cross-build/wasm32-wasip1-threads
TARGET_BUILD_LIB_PATH = $(TARGET_BUILD_PATH)/lib/python$(PYTHON_VERSION_NOPATCH)

WASI_ENV = AR=$(WASI_SDK_PATH)/bin/llvm-ar \
		CC=$(WASI_SDK_PATH)/bin/clang \
		CPP=$(WASI_SDK_PATH)/bin/clang-cpp \
		CXX=$(WASI_SDK_PATH)/bin/clang++ \
		CONFIG_SITE=$(PYTHON_SRC_DIR)/Tools/wasm/wasi/config.site-wasm32-wasi \
		PKG_CONFIG_SYSROOT_DIR=$(WASI_SDK_PATH)/share/wasi-sysroot \
		PKG_CONFIG_LIBDIR=$(WASI_SDK_PATH)/share/wasi-sysroot/lib/pkgconfig:$(WASI_SDK_PATH)/share/wasi-sysroot/share/pkgconfig \
		RANLIB=$(WASI_SDK_PATH)/bin/ranlib \
		WASI_SYSROOT=$(WASI_SDK_PATH)/share/wasi-sysroot

$(eval $(call get-sources,PYTHON))

# Building for WASI requires doing a cross-build where
# you have a build Python to help produce a WASI build of CPython
build_local_python: | $(PYTHON_SRC_DIR)
	mkdir -p $(GNU_BUILD_PATH) && \
	cd $(GNU_BUILD_PATH) && \
	../../configure --disable-test-modules --with-ensurepip=no && \
	make -j $(shell nproc)

build_python_wasi: build_local_python $(PYTHON_DEPENDENCIES) $(PYTHON_SRC_DIR)/.patched
	cd $(PYTHON_SRC_DIR) && \
	sed -i 's|--max-memory=[0-9]*|--max-memory=4294967296|g' ./configure.ac && \
	autoconf -f && \
	$(WASI_ENV) ./configure --host=wasm32-wasip1 --build=x86_64-pc-linux-gnu --with-build-python=$(GNU_BUILD_PATH)/python \
		--enable-wasm-pthreads --with-ensurepip=no --disable-test-modules --disable-ipv6 \
		--prefix=$(TARGET_BUILD_PATH) && \
	make -j $(shell nproc) all && \
	make install

$(PYTHON_BUILD): build_python_wasi
	cp $(TARGET_BUILD_PATH)/bin/python3.wasm $@
	wasm-strip $@

remove_lib_buildfiles:
	find $(TARGET_BUILD_LIB_PATH) -depth -name '__pycache__' \
		-exec rm -rf {} \;
	rm -rf $(TARGET_BUILD_LIB_PATH)/config-*-wasm32-wasi

PYTHON: $(PYTHON_BUILD) remove_lib_buildfiles
	$(INSTALL) -D $< $(ROOTFS_DIR)/usr/bin/python
	mkdir -p $(ROOTFS_DIR)/lib
	cp -r $(TARGET_BUILD_LIB_PATH) $(ROOTFS_DIR)/lib/

.PHONY: PYTHON build_local_python build_python_wasi remove_lib_buildfiles

define PYTHON_CLEAN_CMDS_EXTRA
	rm -rf $(PYTHON_BUILD_DIR)
endef

$(eval $(call apply-patches,PYTHON))
