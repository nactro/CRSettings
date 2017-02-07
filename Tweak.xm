#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import "CReachabilityController.h"
#import "Defines.h"

#define kBundlePath @"/Library/Application Support/CRSettings/CRSettings.bundle"
static BOOL enabled = NO;
// for iOS9&iOS10
%hook SBMainWorkspace
-(void)handleReachabilityModeActivated {
	%orig;
	if (enabled){
		SBWindow *backgroundView = MSHookIvar<SBWindow*>(self,"_reachabilityEffectWindow");
		[[CReachabilityController sharedInstance] setBackgroundWindow:backgroundView];
		[[CReachabilityController sharedInstance] setupImage];
	}
	}
%end
static void loadPrefs()
{

    CFPreferencesAppSynchronize(CFSTR("com.watcher.crsettings"));
    enabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.watcher.crsettings")) ? NO : [(id)CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.watcher.crsettings")) boolValue];
    if (enabled) {
        NSLog(@"Enabled");
    } else {
        NSLog(@"NOT!Enabled");
    }
}

%ctor
{
	NSLog(@"Loading..");
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                NULL,
                                (CFNotificationCallback)loadPrefs,
                                CFSTR("com.watcher.crsettings.settings/changed"),
                                NULL,
                                CFNotificationSuspensionBehaviorDeliverImmediately);
	loadPrefs();
}
