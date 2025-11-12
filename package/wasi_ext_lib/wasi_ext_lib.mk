WASI_EXT_LIB_DEPENDENCIES := WASI_SDK
WASI_EXT_LIB_PKG_NAME := wasi_ext_lib

WASI_EXT_LIB_SRC_REV := f134f7da34bf507957fa7b3ecb305194f9c42ecf
WASI_EXT_LIB_SRC_URL := $(call github_url,antmicro,wasi_ext_lib,$(WASI_EXT_LIB_SRC_REV))

WASI_EXT_LIB_INLUDE_PATH = $(WASI_EXT_LIB_SRC_DIR)/c_lib
WASI_EXT_LIB_LD_PATH = $(WASI_EXT_LIB_SRC_DIR)/c_lib/bin
WASI_EXT_LIB_PATH = $(WASI_EXT_LIB_LD_PATH)/wasi_ext_lib.o

$(eval $(call get-sources,WASI_EXT_LIB))

.PHONY: $(WASI_EXT_LIB_PATH)
$(WASI_EXT_LIB_PATH): | $(WASI_EXT_LIB_SRC_DIR)
	export WASI_SDK_PATH=$(WASI_SDK_PATH) && \
	cd $(WASI_EXT_LIB_SRC_DIR)/c_lib && \
	make -j$(shell nproc)
	wasm-strip $@

.PHONY: WASI_EXT_LIB
WASI_EXT_LIB: $(WASI_EXT_LIB_PATH)
