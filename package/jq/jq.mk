JQ_DEPENDENCIES := WASI_SDK WASI_EXT_LIB
JQ_PKG_NAME := jq

JQ_SRC_REV := 585570cb5c8e6a514b9e4b6a419dbe0d9c80f3bb
JQ_SRC_URL := https://github.com/rockwotj/jq-wasi
JQ_SRC_DIR := $(BUILD_DIR)/jq-$(JQ_SRC_REV)

JQ_BUILD := $(JQ_SRC_DIR)/jq
JQ_DIST := $(ROOTFS_DIR)/usr/bin/jq

JQ_PATCHES := $(wildcard $(PACKAGE_DIR)/jq/*.patch)

$(JQ_BUILD): JQ_PATCH | $(JQ_SRC_DIR) $(JQ_DEPENDENCIES)
	export CC="$(WASI_SDK_PATH)/bin/clang" && \
	export CFLAGS="-O2 -D_WASI_EMULATED_SIGNAL -I $(WASI_EXT_LIB_INLUDE_PATH) $(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS) -L$(WASI_EXT_LIB_LD_PATH) -lwasi_ext_lib -lwasi-emulated-signal" && \
	cd $(JQ_SRC_DIR) && \
	autoreconf -i && \
	./configure --host=wasm32-wasi --target=wasm32-wasi --disable-docs --disable-valgrind --disable-maintainer-mode --with-onigurama=builtin --prefix=/usr/local && \
	make -j$(shell nproc)

$(JQ_DIST): $(JQ_BUILD) | $(ROOTFS_DIR)
	install -D $(JQ_BUILD) $(JQ_DIST)

.PHONY: JQ
JQ: $(JQ_DIST)

$(eval $(call get-sources-git,JQ))
$(eval $(call apply-patches,JQ))
