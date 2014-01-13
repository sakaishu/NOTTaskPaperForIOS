//
//  ViewController.m
// PlainText
//
//  Created by Jesse Grosjean on 6/23/10.
//

#import "ViewController.h"
#import "ApplicationViewController.h"
#import "BrowserViewController.h"


@implementation ViewController

- (void)dealloc {
	parentViewController = nil;
}

@synthesize view;

- (UIView *)view {
	if (!view) {
		[self loadView];
	}
	return view;
}

@synthesize title;

- (void)setTitle:(NSString *)aTitle {
	if (![title isEqualToString:aTitle]) {
		title = aTitle;
		self.browserViewController.title = title;
	}
}

- (NSArray *)toolbarItems {
	return nil;
}

@synthesize parentViewController;

- (BrowserViewController *)browserViewController {
	ViewController *each = self.parentViewController;
	while (each) {
		if ([each isKindOfClass:[BrowserViewController class]]) {
			return (id) each;
		}
		each = each.parentViewController;
	}
	return nil;
}

- (void)loadView {
	self.view = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidLoad {
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return YES;
}

@end
