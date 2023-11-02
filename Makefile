PACKAGE_DIR ?= $(shell pwd)/package
WORK_DIR ?= $(shell pwd)/work
OUT_DIR ?= $(WORK_DIR)/out
BUILD_DIR := $(WORK_DIR)/build

PACKAGES := wasi-sdk coreutils

include ./package/cargo-package.mk

$(foreach package,$(PACKAGES),$(eval include ./package/$(package)/$(package).mk))

$(WORK_DIR):
	@mkdir -p $(WORK_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(OUT_DIR):
	@mkdir -p $(OUT_DIR)

all: COREUTILS
