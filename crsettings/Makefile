ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CRSettings
CRSettings_FILES = CRSettingsRootListController.mm
CRSettings_INSTALL_PATH = /Library/PreferenceBundles
CRSettings_FRAMEWORKS = UIKit
CRSettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CRSettings.plist$(ECHO_END)
