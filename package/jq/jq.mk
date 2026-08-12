JQ_DEPENDENCIES := WASI_SDK WASI_EXT_LIB SYSROOT
JQ_PKG_NAME := jq

JQ_SRC_REV := 585570cb5c8e6a514b9e4b6a419dbe0d9c80f3bb
JQ_SRC_URL := https://github.com/rockwotj/jq-wasi
JQ_SRC_DIR := $(BUILD_DIR)/jq-$(JQ_SRC_REV)

JQ_BUILD := $(JQ_SRC_DIR)/jq
JQ_DIST := $(ROOTFS_DIR)/usr/bin/jq

$(JQ_BUILD): | $(JQ_SRC_DIR) $(JQ_DEPENDENCIES)
	export CC="$(WASI_SDK_CLANG)" && \
	export CFLAGS="-O2 -std=gnu99 -D_WASI_EMULATED_SIGNAL -mthread-model single -mno-atomics -mno-bulk-memory -Wno-incompatible-function-pointer-types -I $(SYSROOT_INC) $(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS) -L$(SYSROOT_LIB)" && \
	export LIBS="-Wl,--whole-archive,-lwasi_ext_lib,--no-whole-archive -lwasi-emulated-signal" && \
	cd $(JQ_SRC_DIR) && \
	autoreconf -i && \
	./configure --host=$(WASI_TARGET) --target=$(WASI_TARGET) --disable-docs --disable-valgrind --disable-maintainer-mode --with-oniguruma=builtin --prefix=/usr/local && \
	make -j$(shell nproc)

	wasm-strip $@

$(JQ_DIST): $(JQ_BUILD) | $(ROOTFS_DIR)
	install -D $(JQ_BUILD) $(JQ_DIST)

.PHONY: JQ
JQ: $(JQ_DIST)

define JQ_CLEAN_CMDS_EXTRA
	rm -f $(JQ_DIST) $(JQ_BUILD)
endef

$(eval $(call get-sources-git,JQ))

