################################################################################
#
# SDL_Compat shim library
#
################################################################################

SDL_VERSION = ea74df64eb66bacca41db3c53eb1af3fb805bf11
SDL_SITE = $(call github,gameblabla,sdl12-compat,$(SDL_VERSION))
SDL_INSTALL_STAGING = YES
SDL_DEPENDENCIES = host-pkgconf sdl2

ifeq ($(BR2_STATIC_LIBS),y)
SDL_CONF_OPTS += STATIC_ENABLED=1
endif

SDL_MAKE_ENV = AS="$(TARGET_AS)" CC="$(TARGET_CC)" PREFIX=/usr PKG_CONFIG="$(BASE_DIR)/host/bin/pkg-config" CFLAGS="$(TARGET_CFLAGS) -fPIC -flto"

define SDL_BUILD_CMDS
	$(SDL_MAKE_ENV) $(MAKE) -C $(@D) $(SDL_CONF_OPTS)
endef

define SDL_INSTALL_STAGING_CMDS
	$(SDL_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install-headers install-lib
endef

define SDL_INSTALL_TARGET_CMDS
	$(SDL_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))
