#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import "CReachabilityController.h"
// for iOS9&iOS10
%hook SBMainWorkspace
-(void)handleReachabilityModeActivated {
	%orig;
		SBWindow *backgroundView = MSHookIvar<SBWindow*>(self,"_reachabilityEffectWindow");
		[[CReachabilityController sharedInstance] setBackgroundWindow:backgroundView];
		[[CReachabilityController sharedInstance] setupImage];
	}
%end
