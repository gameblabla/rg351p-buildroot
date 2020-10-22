################################################################################
#
# FLUIDLITE
#
################################################################################

FLUIDLITE_VERSION = fdd05bad03cdb24d1f78b5fe3453842890c1b0e8
FLUIDLITE_SITE = $(call github,gcw0,FluidLite,$(FLUIDLITE_VERSION))
FLUIDLITE_LICENSE = LGPL-2.1+
FLUIDLITE_LICENSE_FILES = LICENSE
FLUIDLITE_INSTALL_STAGING = YES
FLUIDLITE_DEPENDENCIES = 

$(eval $(cmake-package))
