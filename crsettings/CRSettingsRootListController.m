#include "CRSettingsRootListController.h"

#define BG_COLOR		[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1] // blackColor
#define VERSION_COLOR		[UIColor colorWithRed:56/255.0 green:56/255.0 blue:58/255.0 alpha:1] // systemGrayColor
#define kDeviceWidth       [UIScreen mainScreen].bounds.size.width  
#define kImagePath @"/var/mobile/Documents/crsettings.png"

@implementation CRSettingsRootListController

static float headerHeight = 140.0f; //静态常量

#define VERSION_STRING	@"v2.0.0 - Take immediate effect !"

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
		UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,kDeviceWidth,headerHeight)];
		headerView.opaque = NO;
		headerView.backgroundColor = UIColor.clearColor;

		CGRect frame = CGRectMake(15,47,headerView.bounds.size.width,50);
		UILabel *tweakTitle = [[UILabel alloc] initWithFrame:frame];
		tweakTitle.text = @"CRSettings";
		tweakTitle.font = [UIFont systemFontOfSize:40 weight:UIFontWeightThin];
		tweakTitle.textColor = UIColor.blackColor;
		//tweakTitle.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		tweakTitle.textAlignment = NSTextAlignmentCenter;
		[headerView addSubview:tweakTitle];

		CGRect subtitleFrame = CGRectMake(15, 98, headerView.bounds.size.width, 20);
		UILabel *tweakSubtitle = [[UILabel alloc] initWithFrame:subtitleFrame];
		tweakSubtitle.text = VERSION_STRING;
		tweakSubtitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
		tweakSubtitle.textColor = VERSION_COLOR;
		//tweakSubtitle.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		tweakSubtitle.textAlignment = NSTextAlignmentCenter;
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

- (void)selectfromPhotos {
/**
     *  弹出提示框
     */
            //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
            //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
            //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
            //自代理
        PickerImage.delegate = self;
            //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
        //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
        //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//常量
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"crsettings.png"];
    //extracting image from the picker and saving it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType]; 

    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *writeData = UIImagePNGRepresentation(editedImage);
        [writeData writeToFile:imagePath atomically:YES];
    }

    [self dismissViewControllerAnimated:YES completion:nil];


}


- (void)clearImages {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:kImagePath error:nil];

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
