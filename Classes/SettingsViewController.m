//
//  SettingsViewController.m
//  PlainText
//
//  Created by Jesse Grosjean on 6/30/10.
//

#import "SettingsViewController.h"
#import "TextExpanderSettingsViewController.h"
#import "FontAndColorSettingsViewController.h"
#import "AdvancedSettingsViewController.h"
#import "DropboxSettingsViewController.h"
#import "ApplicationViewController.h"
#import "IFSwitchCellController.h"
#import "IFSwitchCellController.h"
#import "IFButtonCellController.h"
#import "HelpSectionController.h"
#import "IFSliderCellController.h"
#import "IFChoiceCellController.h"
#import "ApplicationController.h"
#import "IFTextCellController.h"
#import "IFLinkCellController.h"
#import "IFPreferencesModel.h"
#import "IFTemporaryModel.h"

@interface MyNavigationController : UINavigationController {
}
@end

@implementation MyNavigationController

static BOOL _showing;

+ (BOOL)showing {
    return _showing;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _showing = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _showing = NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([APP_VIEW_CONTROLLER lockOrientation]) {
        if ([APP_VIEW_CONTROLLER lockedOrientation] == UIDeviceOrientationPortrait)
            return UIInterfaceOrientationMaskPortrait;
        else if ([APP_VIEW_CONTROLLER lockedOrientation] == UIInterfaceOrientationPortraitUpsideDown)
            return UIInterfaceOrientationMaskPortraitUpsideDown;
        else if ([APP_VIEW_CONTROLLER lockedOrientation] == UIInterfaceOrientationLandscapeLeft)
            return UIInterfaceOrientationMaskLandscapeLeft;
        else if ([APP_VIEW_CONTROLLER lockedOrientation] == UIInterfaceOrientationLandscapeRight)
            return UIInterfaceOrientationMaskLandscapeRight;
        else
            return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskAll;
}

- (void)setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (animated) {
        [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationSlide];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationNone];
    }
	
	if (!IS_IPAD) {
		if (animated) {
			[UIView beginAnimations:nil context:NULL];
		}
		
		CGAffineTransform t = self.view.transform;
		UIInterfaceOrientation orientation = self.interfaceOrientation;
		BOOL isLandscape = UIInterfaceOrientationIsLandscape(orientation);
		
		CGRect goodBounds = [[UIScreen mainScreen] bounds];
		
		CGSize statusSize = [[UIApplication sharedApplication] statusBarFrame].size;
		CGSize statusSize_t = CGSizeApplyAffineTransform(statusSize, t); // discard status frame origin
		CGFloat statusHeight = fabs(statusSize_t.height);
		CGFloat statusHeight_t = statusSize_t.height; // discard status width
		
		// tricky part
		CGRect goodFrame = goodBounds;
		goodFrame.size.width -= isLandscape ? statusHeight : 0;
		goodFrame.size.height -= isLandscape ? 0 : statusHeight;
		CGRect goodFrame_t = CGRectApplyAffineTransform(goodFrame, t);
		self.view.bounds = CGRectMake(0, 0, goodFrame_t.size.width, goodFrame_t.size.height);
		
		CGFloat dx = isLandscape ? -statusHeight_t/2 : 0;
		CGFloat dy = isLandscape ? 0 : statusHeight_t/2;
		
		self.view.center = CGPointMake(goodBounds.size.width/2 + dx, goodBounds.size.height/2 + dy);
		
		if (animated) {
			[UIView commitAnimations];
		}		
	}
}

@end

@implementation SettingsViewController

+ (BOOL)showing {
    return [MyNavigationController showing];
}

+ (UINavigationController *)viewControllerForDisplayingSettings {
	UINavigationController *navigationController = [[MyNavigationController alloc] init];
	SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
	
	settingsViewController.model = [[IFPreferencesModel alloc] init];
	
	navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	if ([navigationController respondsToSelector:@selector(setModalPresentationStyle:)]) {
		navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
	}
	
	navigationController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	[navigationController pushViewController:settingsViewController animated:NO];
	
	return navigationController;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView {
	[super loadView];
	self.title = NSLocalizedString(@"Settings", nil);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Close", nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissModalViewControllerAction:)];		
}

- (void)constructTableGroups {
	NSMutableArray *groupOneCells = [NSMutableArray array];
	NSMutableArray *groupTwoCells = [NSMutableArray array];
	NSMutableArray *groupThreeCells = [NSMutableArray array];
	NSString *processName = [[NSProcessInfo processInfo] processName];
	IFLinkCellController *linkCell;
	
	// Group 1
    NSString *versionKey = (id)kCFBundleVersionKey;
	NSString *version = [[NSBundle mainBundle] infoDictionary][versionKey];
	IFTemporaryModel *tempModel = [[IFTemporaryModel alloc] initWithDictionary:@{@"version": version}];
	IFTextCellController *textCell = [[IFTextCellController alloc] initWithLabel:processName andPlaceholder:nil atKey:@"version" inModel:tempModel];
	textCell.enabled = NO;
	[groupOneCells addObject:textCell];
	
	// Group 2
		
	linkCell = [[IFLinkCellController alloc] initWithLabel:NSLocalizedString(@"Dropbox", nil) usingController:[[DropboxSettingsViewController alloc] init] inModel:model];
	linkCell.image = [UIImage imageNamed:@"dropbox.png"];
	[groupTwoCells addObject:linkCell];

#if !defined(PLAINTEXT)
	linkCell = [[IFLinkCellController alloc] initWithLabel:NSLocalizedString(@"Fonts & Colors", nil) usingController:[[FontAndColorSettingsViewController alloc] init] inModel:model];
	linkCell.image = [UIImage imageNamed:@"fonts_small.png"];
	[groupTwoCells addObject:linkCell];
#endif
	
	linkCell = [[IFLinkCellController alloc] initWithLabel:NSLocalizedString(@"TextExpander", nil) usingController:[[TextExpanderSettingsViewController alloc] init] inModel:model];
	linkCell.image = [UIImage imageNamed:@"IconTEBarButton.png"];
	[groupTwoCells addObject:linkCell];
	
	linkCell = [[IFLinkCellController alloc] initWithLabel:NSLocalizedString(@"Advanced", nil) usingController:[[AdvancedSettingsViewController alloc] init] inModel:model];
	linkCell.image = [UIImage imageNamed:@"wand_small.png"];
	[groupTwoCells addObject:linkCell];

	linkCell = [[IFLinkCellController alloc] initWithLabel:NSLocalizedString(@"Help", nil) usingController:[[HelpSectionController alloc] init] inModel:self.model];
	linkCell.image = [UIImage imageNamed:@"question_small.png"];
	[groupTwoCells addObject:linkCell];
	
	// Group 3
			
	tableGroups = @[groupOneCells, groupTwoCells, groupThreeCells];
	tableHeaders = @[@"", @"", @"", @""];
	tableFooters = @[NSLocalizedString(@"Created by SOMEBODY", nil), @"", @"", @""];
}

- (void)privacyPolicy {
}

@end