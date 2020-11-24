################################################################################
#
# SDL_Lite 1.2.x
#
################################################################################

SDL_VERSION = b01791f9dc401a189c63213adcec99c1a0a4422f
SDL_SITE = $(call github,gameblabla,SDL_Lite,$(SDL_VERSION))
SDL_INSTALL_STAGING = YES
SDL_DEPENDENCIES = host-pkgconf libgo2

ifeq ($(BR2_STATIC_LIBS),y)
SDL_CONF_OPTS += STATIC_ENABLED=1
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SDL_DEPENDENCIES += alsa-lib
SDL_CONF_OPTS += ALSA=1
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
SDL_DEPENDENCIES += pulseaudio
SDL_CONF_OPTS += PULSE=1
endif

# Enables ARMv8 + NEON code. For now though, it is not used internally by SDL
ifeq ($(BR2_ARM_FPU_NEON_FP_ARMV8),y)
SDL_CONF_OPTS += NEON_A64=1
else
# Only for ARM 32-bits
ifeq ($(BR2_ARM_CPU_HAS_ARM)$(BR2_ARM_CPU_HAS_NEON),yy)
SDL_CONF_OPTS += NEON=1
endif
endif

ifeq ($(BR2_PACKAGE_SDL_FBCON),y)
SDL_CONF_OPTS += FBDEV=1
endif

ifeq ($(BR2_PACKAGE_SDL_KMSDRM),y)
SDL_CONF_OPTS += KMSDRM=1
endif

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
