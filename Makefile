TARGET = iphone:clang:12.0:latest

include $(THEOS)/makefiles/common.mk

DEBUG = 1

ARCHS = arm64 arm64e

TWEAK_NAME = FindingHook

$(TWEAK_NAME)_FILES = $(wildcard *.xm)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"

include $(THEOS_MAKE_PATH)/aggregate.mk