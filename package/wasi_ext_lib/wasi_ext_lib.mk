WASI_EXT_LIB_DEPENDENCIES := WASI_SDK HOST_SYSROOT
WASI_EXT_LIB_PKG_NAME := wasi_ext_lib

WASI_EXT_LIB_SRC_REV := 067db2ace9997d13af5709ffd8d66ecbbc7d5a52
WASI_EXT_LIB_SRC_URL := $(call github_url,antmicro,wasi_ext_lib,$(WASI_EXT_LIB_SRC_REV))

WASI_EXT_LIB_LIB := $(HOST_SYSROOT_LIB)/libwasi_ext_lib.a

$(eval $(call get-sources,WASI_EXT_LIB))

$(WASI_EXT_LIB_LIB): | $(WASI_EXT_LIB_SRC_DIR) $(WASI_EXT_LIB_DEPENDENCIES)
	export WASI_SDK_PATH=$(WASI_SDK_PATH) && \
	export CFLAGS="$(CFLAGS) -matomics -mbulk-memory -mmutable-globals" && \
	cd $(WASI_EXT_LIB_SRC_DIR)/c_lib && \
	make -j$(shell nproc) all

.PHONY: WASI_EXT_LIB
WASI_EXT_LIB: $(WASI_EXT_LIB_LIB)
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/bin/libwasi_ext_lib.a $(HOST_SYSROOT_LIB)/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/bin/libwasi_c_sup.a $(HOST_SYSROOT_LIB)/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/wasi_ext_lib.h $(HOST_SYSROOT_INC)/
	mkdir -p $(HOST_SYSROOT_INC)/third_party
	cp -r $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/* $(HOST_SYSROOT_INC)/third_party/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/json/json.h $(HOST_SYSROOT_INC)/
	cp $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/termios/termios.h $(HOST_SYSROOT_INC)/
	cp -r $(WASI_EXT_LIB_SRC_DIR)/c_lib/third_party/termios/bits $(HOST_SYSROOT_INC)/

define WASI_EXT_LIB_CLEAN_CMDS_EXTRA
	rm -f $(HOST_SYSROOT_LIB)/libwasi_ext_lib.a $(HOST_SYSROOT_LIB)/libwasi_c_sup.a $(HOST_SYSROOT_INC)/wasi_ext_lib.h $(HOST_SYSROOT_INC)/json.h $(HOST_SYSROOT_INC)/termios.h
	rm -rf $(HOST_SYSROOT_INC)/third_party $(HOST_SYSROOT_INC)/bits
endef
