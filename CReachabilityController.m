#import "CReachabilityController.h"
#import <QuartzCore/QuartzCore.h>


@implementation CReachabilityController

//Shared Instance
+(instancetype)sharedInstance {
	static dispatch_once_t pred;
	static CReachabilityController *shared = nil;

	dispatch_once(&pred, ^{
		shared = [[CReachabilityController alloc] init];
	});
	return shared;
}

//Image setup
-(void)setBackgroundWindow:(SBWindow*)window {
	backgroundWindow = window;
}

-(void)setupImage {

	if (backgroundWindow) {

		UIImage *CRImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/CRSettings.bundle/Custom.jpg"];
		CRImageview = [[[UIImageView alloc] initWithFrame:backgroundWindow.bounds]initWithImage:CRImage];
		CRImageview.contentMode = UIViewContentModeScaleAspectFit;
	    CRImageview.clipsToBounds = NO;
		[backgroundWindow addSubview:CRImageview];

	}
}

@end
