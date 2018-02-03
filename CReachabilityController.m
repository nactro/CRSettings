#import "CReachabilityController.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "Defines.h"

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

		NSString *pictureName = @"crsettings.png";
		NSString *picturePath = [kImageDirectory stringByAppendingPathComponent:pictureName];
		UIImage *CRImage = [UIImage imageWithContentsOfFile:picturePath];
		CRImageview = [[[UIImageView alloc] initWithFrame:backgroundWindow.bounds]initWithImage:CRImage];
		CRImageview.contentMode = UIViewContentModeScaleAspectFit;
	    CRImageview.clipsToBounds = NO;
		[backgroundWindow addSubview:CRImageview];

	}
}

@end
