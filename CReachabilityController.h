#import <UIKit/UIKit.h>

@interface SBWindow : UIWindow
@end

@interface CReachabilityController : UIViewController {

	SBWindow *backgroundWindow;
	UIImageView *CRImageview;
}

+(instancetype)sharedInstance;
-(void)setBackgroundWindow:(SBWindow*)window;
-(void)setupImage;

@end
