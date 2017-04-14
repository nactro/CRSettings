#include "CRSettingsRootListController.h"

#define BG_COLOR		[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1] // blackColor
#define VERSION_COLOR		[UIColor colorWithRed:56/255.0 green:56/255.0 blue:58/255.0 alpha:1] // systemGrayColor

@implementation CRSettingsRootListController

static float headerHeight = 140.0f;
#define VERSION_STRING	@"v2.0.0 - No Respring !"

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
/* Tint navbar items. */
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	// tint navbar
	self.navigationController.navigationBar.backgroundColor = BG_COLOR;
}
- (void)viewWillDisappear:(BOOL)animated {
	// un-tint navbar
	self.navigationController.navigationController.navigationBar.tintColor = nil;

	[super viewWillDisappear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
//TODO
}

/* over-write class method */
-(id)tableView:(id)tableView viewForHeaderInSection:(NSInteger)section{
	if(section !=0){
		return [super tableView:tableView viewForHeaderInSection:section];
	}
	if (!self.headerView) {
		/* initlize headerView */
		UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,headerHeight)];
		headerView.opaque = NO;
		headerView.backgroundColor = UIColor.clearColor;

		CGRect frame = CGRectMake(15,47,headerView.bounds.size.width,50);
		UILabel *tweakTitle = [[UILabel alloc] initWithFrame:frame];
		tweakTitle.text = @"CRSettings";
		tweakTitle.font = [UIFont systemFontOfSize:40 weight:UIFontWeightThin];
		tweakTitle.textColor = UIColor.blackColor;
		//tweakTitle.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		tweakTitle.textAlignment = UITextAlignmentCenter;
		[headerView addSubview:tweakTitle];

		CGRect subtitleFrame = CGRectMake(15, 98, headerView.bounds.size.width, 20);
		UILabel *tweakSubtitle = [[UILabel alloc] initWithFrame:subtitleFrame];
		tweakSubtitle.text = VERSION_STRING;
		tweakSubtitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
		tweakSubtitle.textColor = VERSION_COLOR;
		//tweakSubtitle.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		tweakSubtitle.textAlignment = UITextAlignmentCenter;
		[headerView addSubview:tweakSubtitle];
		//initlize
		self.headerView = headerView;
	}
	return self.headerView;
}
- (CGFloat)tableView:(id)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return headerHeight;
	} else {
		return [super tableView:tableView heightForHeaderInSection:section];
	}
}


/* Major Functions in Prefs */

- (void)SelectfromPhotos {

	//TODO

}

- (void)ClearImages {

	//TODO ClearImages

}

/* Major Functions in Prefs */

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

- (void)openDonate {
	NSString *url = @"https://www.paypal.me/ECallan";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
