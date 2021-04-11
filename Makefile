TARGET := iphone:clang:latest:13.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
SYSROOT = $(THEOS)/sdks/iPhoneOS13.3.sdk
TWEAK_NAME = DarkKeysReborn

DarkKeysReborn_FILES = Tweak.x
DarkKeysReborn_CFLAGS = -fobjc-arc
DarkKeysReborn_EXTRA_FRAMEWORKS = Cephei

SUBPROJECTS += Prefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk
