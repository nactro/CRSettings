ARCHS = armv7 arm64
TARGET = iphone:clang:latest:9.3
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CReachability
CReachability_FILES = Tweak.xm CReachabilityController.m
CReachability_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore
CReachability_CFLAGS = -Wno-error
CReachability_LDFLAGS += -Wl,-segalign,4000
export GO_EASY_ON_ME := 1
include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += crsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
before-stage::
	find . -name ".DS_STORE" -delete
after-install::
	install.exec "killall -9 SpringBoard"
