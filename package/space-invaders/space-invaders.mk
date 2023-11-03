SPACE_INVADERS_DEPENDENCIES := RUST WASI_SDK

SPACE_INVADERS_SRC_REV := d5fdeb2d0cf38d9cdfdabcdbc4be3d9ad29e68cd
SPACE_INVADERS_SRC_URL := https://github.com/mia1024/space-invaders/archive/$(SPACE_INVADERS_SRC_REV).zip
SPACE_INVADERS_SRC_ZIP := $(BUILD_DIR)/$(SPACE_INVADERS_SRC_REV).zip
SPACE_INVADERS_SRC_DIR := $(BUILD_DIR)/space-invaders-$(SPACE_INVADERS_SRC_REV)

SPACE_INVADERS_TARGET := $(SPACE_INVADERS_SRC_DIR)/target/wasm32-wasi/release/space-invaders.wasm
SPACE_INVADERS_DIST := $(RESOURCES_DIR)/space-invaders
SPACE_INVADERS_PATCHES := $(wildcard $(PACKAGE_DIR)/space-invaders/*.patch)

$(eval $(call cargo-package,SPACE_INVADERS))
