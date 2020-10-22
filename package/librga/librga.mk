################################################################################
#
# librga
#
################################################################################

LIBRGA_VERSION = b20975d50
LIBRGA_SITE = $(call github,Caesar-github,linux-rga,$(LIBRGA_VERSION))
LIBRGA_LICENSE = GPLv2
LIBRGA_INSTALL_STAGING = YES

LIBRGA_DEPENDENCIES = \
	libdrm \
	host-pkgconf

LIBRGA_CONF_OPTS = 

ifeq ($(BR2_PACKAGE_LIBDRM),y)
LIBRGA_DEPENDENCIES += libdrm
LIBRGA_CFLAGS += -DLIBDRM=1
endif


$(eval $(meson-package))
