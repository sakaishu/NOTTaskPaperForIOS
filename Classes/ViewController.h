//
//  ViewController.h
// PlainText
//
//  Created by Jesse Grosjean on 6/23/10.
//


@class BrowserViewController;

@interface ViewController : NSObject {
	UIView *view;
	NSString *title;
	//NSArray *toolbarItems;
	ViewController *__weak parentViewController;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *title;
@property (weak, nonatomic, readonly) NSArray *toolbarItems;
@property (nonatomic, weak) ViewController *parentViewController;
@property (weak, nonatomic, readonly) BrowserViewController *browserViewController;

- (void)loadView;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;

@end
