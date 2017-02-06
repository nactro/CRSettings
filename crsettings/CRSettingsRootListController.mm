
#import <Preferences/PSListController.h>
#import <Preferences/PSSwitchTableCell.h>

@interface CRSettingsRootListController : PSListController

@end

@implementation CRSettingsRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
- (void)viewDidLoad {
	[super viewDidLoad];

	// Add Table Header...

	UIImage *logoImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/CRSettings.bundle/header.png"];
	UIImageView *logoView = [[UIImageView alloc] initWithImage:logoImage];
	logoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

	UIView *headerView = [[UIView alloc] initWithFrame:logoView.frame];
	headerView.backgroundColor = [UIColor clearColor];
	[headerView addSubview:logoView];
	[self.table setTableHeaderView:headerView];

}
/**Actions**/
- (void)openEmail {
	NSString *subject = @"CRSettings Support";
	NSString *body = @"";
	NSString *urlString = [NSString stringWithFormat:@"mailto:lazysloths@yahoo.com?subject=%@&body=%@", subject, body];
	NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
	[[UIApplication sharedApplication] openURL:url];
}
-(void)openWeibo{
	NSURL *WeiboUrl;
	WeiboUrl= [NSURL URLWithString:@"http://weibo.com/cinbv"];
	[[UIApplication sharedApplication] openURL:WeiboUrl];
}
- (void)openTwitter {
	NSURL *url;

	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		url = [NSURL URLWithString:@"tweetbot:///user_profile/ryaneddisford"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
		url = [NSURL URLWithString:@"twitterrific:///profile?screen_name=ryaneddisford"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
		url = [NSURL URLWithString:@"tweetings:///user?screen_name=ryaneddisford"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		url = [NSURL URLWithString:@"twitter://user?screen_name=ryaneddisford"];
	} else {
		url = [NSURL URLWithString:@"https://twitter.com/ryaneddisford"];
	}

	[[UIApplication sharedApplication] openURL:url];
}
- (void)openGitHub {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/CallanThorse"]];
}
- (void)openGitHubIssue {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://github.com/CallanThorse/CRSettings/issues"]];
}
- (void)openBlog {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cuffeer.com/"]];
}
- (void)openDonate {
	NSString *url = @"https://www.paypal.me/ECallan";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
