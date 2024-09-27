RUST_DEPENDENCIES := WASI_SDK
RUST_PKG_NAME := rust

RUST_SRC_REV := eeb90cda1969383f56a2637cbd3037bdf598841c
RUST_SRC_URL := https://github.com/rust-lang/rust.git
RUST_SRC_DIR := $(BUILD_DIR)/rust-$(RUST_SRC_REV)

RUST_CONFIG := $(RUST_SRC_DIR)/config.toml
RUST_PATCHES := $(wildcard $(PACKAGE_DIR)/rust/*.patch)

RUST_TOOLCHAIN = $(RUST_SRC_DIR)/build/host/stage1
CARGO = WASI_SDK_PATH=$(WASI_SDK_PATH) cargo +wasi_extended

# patches are always applied, hence no-order dependency
# this target won't be remade when patches update
$(RUST_CONFIG): | $(RUST_SRC_DIR) $(RUST_SRC_DIR)/.patched
	@rm -f $(RUST_CONFIG)
	@cd $(RUST_SRC_DIR) && \
	./configure \
		--target wasm32-wasi \
		--disable-docs \
		--set target.wasm32-wasi.wasi-root=$(WASI_SDK_PATH)/share/wasi-sysroot \
		--set llvm.download-ci-llvm=false \
		--enable-lld \
		--tools cargo

.PHONY: $(RUST_TOOLCHAIN)
$(RUST_TOOLCHAIN): $(RUST_CONFIG) | $(RUST_DEPENDENCIES)
	@cd $(RUST_SRC_DIR) && \
	export PATH=$$PATH:$(RUST_SRC_DIR)/build/host/llvm/bin && \
	./x.py build --target wasm32-wasi,x86_64-unknown-linux-gnu --stage 1

# TODO: Don't install the toolchain globally, use local rustup
.PHONY: RUST_TOOLCHAIN_LINK
RUST_TOOLCHAIN_LINK: $(RUST_TOOLCHAIN)
	@rustup toolchain link wasi_extended $(RUST_TOOLCHAIN)

.PHONY: RUST
RUST: RUST_TOOLCHAIN_LINK

$(eval $(call get-sources-git,RUST))
$(eval $(call apply-patches,RUST))
