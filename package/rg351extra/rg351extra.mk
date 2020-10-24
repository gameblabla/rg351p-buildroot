################################################################################
#
# RG351EXTRA
#
################################################################################

RG351EXTRA_VERSION = 7545d00c84384877ed0045a8b4c128348cb5a9cb
RG351EXTRA_SITE = $(call github,gameblabla,rg351pextra,$(RG351EXTRA_VERSION))
RG351EXTRA_LICENSE = GPL-2.0+
RG351EXTRA_LICENSE_FILES = COPYING
RG351EXTRA_INSTALL_STAGING = YES

RG351EXTRA_PROVIDES = libegl libgles

define RG351EXTRA_INSTALL_STAGING_CMDS
	mkdir -p $(TARGET_DIR)/boot
	mkdir -p $(TARGET_DIR)/overlay

	cp -rf $(@D)/usr $(TARGET_DIR)
	cp -rf $(@D)/lib $(TARGET_DIR)
	cp -rf $(@D)/usr $(STAGING_DIR)
	cp -rf $(@D)/lib $(STAGING_DIR)
endef

$(eval $(generic-package))
