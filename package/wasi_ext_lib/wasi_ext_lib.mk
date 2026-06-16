WASI_EXT_LIB_DEPENDENCIES := WASI_SDK
WASI_EXT_LIB_PKG_NAME := wasi_ext_lib

WASI_EXT_LIB_SRC_REV := 09a6dd929012e57c09f66c9b981e406cbca40e46
WASI_EXT_LIB_SRC_URL := $(call github_url,antmicro,wasi_ext_lib,$(WASI_EXT_LIB_SRC_REV))

WASI_EXT_LIB_INCLUDE_PATH = $(WASI_EXT_LIB_SRC_DIR)/c_lib
WASI_EXT_LIB_LD_PATH = $(WASI_EXT_LIB_SRC_DIR)/c_lib/bin
WASI_EXT_LIB_PATH = $(WASI_EXT_LIB_LD_PATH)/wasi_ext_lib.o

$(eval $(call get-sources,WASI_EXT_LIB))

.PHONY: $(WASI_EXT_LIB_PATH)
$(WASI_EXT_LIB_PATH): | $(WASI_EXT_LIB_SRC_DIR)
	export WASI_SDK_PATH=$(WASI_SDK_PATH) && \
	export CFLAGS="$(CFLAGS) -matomics -mbulk-memory -mmutable-globals" && \
	cd $(WASI_EXT_LIB_SRC_DIR)/c_lib && \
	make -j$(shell nproc)
	wasm-strip $@

.PHONY: WASI_EXT_LIB
WASI_EXT_LIB: $(WASI_EXT_LIB_PATH)
