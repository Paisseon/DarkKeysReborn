TARGET := iphone:clang:latest:12.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
SYSROOT = $(THEOS)/sdks/iPhoneOS13.3.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkKeysReborn

DarkKeysReborn_FILES = Tweak.x
DarkKeysReborn_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
