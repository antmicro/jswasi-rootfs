lowercase = $(shell echo $(1) | tr [:upper:] [:lower:])
uppercase = $(shell echo $(1) | tr [:lower:] [:upper:])
