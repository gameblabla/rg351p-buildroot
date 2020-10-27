################################################################################
#
# SDL_Lite 1.2.x
#
################################################################################

SDL_VERSION = 6eb5aa2de7849a1a81ce76633b35e8fff63e5779
SDL_SITE = $(call github,gameblabla,SDL_Lite,$(SDL_VERSION))
SDL_INSTALL_STAGING = YES
SDL_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_STATIC_LIBS),y)
SDL_CONF_OPTS += STATIC=1
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SDL_DEPENDENCIES += alsa-lib
SDL_CONF_OPTS += ALSA=1
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
SDL_DEPENDENCIES += pulseaudio
SDL_CONF_OPTS += PULSE=1
endif

# Only for ARM 32-bits
ifeq ($(BR2_ARM_CPU_HAS_ARM)$(BR2_ARM_CPU_HAS_NEON),yy)
SDL_CONF_OPTS += NEON=1
endif

SDL_CONF_OPTS += KMSDRM=1

SDL_MAKE_ENV = AS="$(TARGET_AS)" CC="$(TARGET_CC)" PREFIX=/usr PKG_CONFIG="$(BASE_DIR)/host/bin/pkg-config" CFLAGS="$(TARGET_CFLAGS) $(LUA_CFLAGS) -flto"

define SDL_BUILD_CMDS
	$(SDL_MAKE_ENV) $(MAKE) -C $(@D) $(SDL_CONF_OPTS)
endef

define SDL_INSTALL_STAGING_CMDS
	$(SDL_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define SDL_INSTALL_TARGET_CMDS
	$(SDL_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))
