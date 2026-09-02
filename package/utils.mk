lowercase = $(shell echo $(1) | tr [:upper:] [:lower:])
uppercase = $(shell echo $(1) | tr [:lower:] [:upper:])

# Target architecture triples
WASI_TARGET := wasm32-wasip1
WASI_TARGET_THREADS := $(WASI_TARGET)-threads

