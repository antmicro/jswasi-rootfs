WASI_EXT_LIB_DEPENDENCIES := WASI_SDK SYSROOT
WASI_EXT_LIB_PKG_NAME := wasi_ext_lib

WASI_EXT_LIB_SRC_REV := 2cc5fb079c97c67e9d014bc7fe84c39af10d5da8
WASI_EXT_LIB_SRC_URL := $(call github_url,antmicro,wasi_ext_lib,$(WASI_EXT_LIB_SRC_REV))

WASI_EXT_LIB_LIB := $(SYSROOT_LIB)/libwasi_ext_lib.a

$(eval $(call get-sources,WASI_EXT_LIB))

$(WASI_EXT_LIB_LIB): | $(WASI_EXT_LIB_SRC_DIR) $(WASI_EXT_LIB_DEPENDENCIES)
	export WASI_SDK_PATH=$(WASI_SDK_PATH) && \
	export CFLAGS="$(CFLAGS) -matomics -mbulk-memory -mmutable-globals" && \
	cd $(WASI_EXT_LIB_SRC_DIR)/c_lib && \
	make -j$(shell nproc)

.PHONY: WASI_EXT_LIB
WASI_EXT_LIB: $(WASI_EXT_LIB_LIB)
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/bin/libwasi_ext_lib.a $(SYSROOT_LIB)/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/wasi_ext_lib.h $(SYSROOT_INC)/
	mkdir -p $(HOST_SYSROOT_INC)/third_party
	cp -r $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/* $(SYSROOT_INC)/third_party/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/json/json.h $(SYSROOT_INC)/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/termios/termios.h $(SYSROOT_INC)/
	cp -r $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/termios/bits $(SYSROOT_INC)/

define WASI_EXT_LIB_CLEAN_CMDS_EXTRA
	rm -f $(SYSROOT_LIB)/libwasi_ext_lib.a $(SYSROOT_INC)/wasi_ext_lib.h $(SYSROOT_INC)/json.h $(SYSROOT_INC)/termios.h
	rm -rf $(SYSROOT_INC)/third_party $(SYSROOT_INC)/bits
endef
