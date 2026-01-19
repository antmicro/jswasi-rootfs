get_source_url = $(subst %OWNER,$(2),$(subst %REPO,$(3),$(subst %VERSION,$(4),$(1))))
github_url = $(call get_source_url,https://github.com/%OWNER/%REPO/archive/%VERSION.zip,$(1),$(2),$(3))

define get-sources

# Variables for targets
$(eval $(1)_SRC_ZIP := $$(BUILD_DIR)/$($(1)_SRC_REV).zip)
$(eval $(1)_SRC_DIR := $$(BUILD_DIR)/$($(1)_PKG_NAME)-$($(1)_SRC_REV))
$(eval $(1)_CLEAN_CMDS := rm -rf $(BUILD_DIR)/$($(1)_SRC_REV).zip $($(1)_SRC_DIR))

# Use default alternate url for the package if provided
$(eval $(1)_SRC_URL += $(call get_source_url,$(ALTERNATE_URL_DEFAULT),,$($(1)_PKG_NAME),$($(1)_SRC_REV)))
# Use explicit alternate url for the package if provided
$(eval $(1)_SRC_URL += $(call get_source_url,$($(1)_ALTERNATE_URL),,$($(1)_PKG_NAME),$($(1)_SRC_REV)))


$($(1)_SRC_ZIP): | $$(BUILD_DIR)
ifdef $(1)_SRC_ZIP_CMDS
	@echo "INFO: Downloading sources for $(1)..."
	$(call $(1)_SRC_ZIP_CMDS)
else
	@echo "INFO: Downloading sources for $(1)..."
	@for url in $$$$(echo $($(1)_SRC_URL) | tac -s' '); do \
		wget -qO $($(1)_SRC_ZIP) $$$${url} && break; \
	done
endif

$($(1)_SRC_DIR): $($(1)_SRC_ZIP) | $$(BUILD_DIR)
ifdef $(1)_SRC_DIR_CMDS
	@echo "INFO: Extracting sources for $(1)..."
	$(call $(1)_SRC_DIR_CMDS)
else
	@echo "INFO: Extracting sources for $(1)..."
	@mkdir -p $($(1)_SRC_DIR)
	@unzip -od $($(1)_SRC_DIR) $($(1)_SRC_ZIP)
	@find $($(1)_SRC_DIR) -mindepth 2 -maxdepth 2 -exec mv -t $($(1)_SRC_DIR) {} \;
	@find $($(1)_SRC_DIR) -empty -type d -delete
endif
endef  # get-sources

define get-sources-git

$(eval $(1)_SRC_DIR := $$(BUILD_DIR)/$($(1)_PKG_NAME)-$($(1)_SRC_REV))
$(eval $(1)_CLEAN_CMDS := rm -rf $($(1)_SRC_DIR))

$($(1)_SRC_DIR): | $$(BUILD_DIR)
ifdef $(1)_SRC_DIR_CMDS
	@echo "INFO: Cloning sources for $(1)..."
	$(call $(1)_SRC_DIR_CMDS)
else
	@echo "INFO: Cloning sources for $(1)..."
	@git clone --no-checkout --depth 1 $($(1)_SRC_URL) $($(1)_SRC_DIR) && \
	cd $($(1)_SRC_DIR) && \
	git fetch --depth 1 origin $($(1)_SRC_REV) && \
	git checkout $($(1)_SRC_REV) && \
	git clean -df && \
	git submodule update --init --recursive --depth 1
endif

endef  # get-sources-git
