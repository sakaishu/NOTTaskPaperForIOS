//
//  KeyboardAccessoryView.m
//  PlainText
//
//  Created by Jesse Grosjean on 4/21/11.
//

#import "KeyboardAccessoryView.h"
#import "ApplicationViewController.h"
#import "ApplicationController.h"
#import "UIResponder_Additions.h"


@interface KeyboardButton : UIButton {
}
@end

@interface KeyboardAccessoryView ()

@property (nonatomic, assign) NSUInteger numberOfExtraButtons;

@end


@implementation KeyboardAccessoryView

- (id)buttonWith:(NSString *)text cropLeft:(BOOL)cropLeft cropRight:(BOOL)cropRight {
	
	UIButton *button = [KeyboardButton buttonWithType:UIButtonTypeRoundedRect];
	UIImage *normal = [UIImage imageNamed:@"blankKey"];
	UIImage *highlighted = [UIImage imageNamed:@"blankKey"];

	normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 18, 20, 18)];
	highlighted = [highlighted resizableImageWithCapInsets:UIEdgeInsetsMake(20, 18, 20, 18)];
    
	[button setBackgroundImage:normal forState:UIControlStateNormal];
	[button setBackgroundImage:highlighted forState:UIControlStateHighlighted];
	[button sizeToFit];
	[button setTitle:text forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(keyDown) forControlEvents:UIControlEventTouchDown];
	[button addTarget:self action:@selector(keyUp:) forControlEvents:UIControlEventTouchUpInside];
	button.titleLabel.font = [UIFont systemFontOfSize:26];
	button.titleLabel.textAlignment = NSTextAlignmentCenter;
	button.accessibilityTraits = UIAccessibilityTraitPlaysSound | UIAccessibilityTraitKeyboardKey;

	return button;
}

- (CGSize)sizeThatFits:(CGSize)size forOrientation:(UIInterfaceOrientation)orientation {
	BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);
	if (isPortrait) {
		size.height = 72;
	} else {
		size.height = 72;
	}
	return size;
}

- (id)init {
    self = [super initWithFrame:CGRectZero inputViewStyle:UIInputViewStyleKeyboard];
    if (self) {
		self.numberOfExtraButtons = 0;
		self.userInteractionEnabled = YES;

		CGRect f = self.frame;
		f.size = [self sizeThatFits:f.size forOrientation:APP_VIEW_CONTROLLER.interfaceOrientation];
		self.frame = f;
		
		UIButton *tab = [self buttonWith:@"tab" cropLeft:NO cropRight:NO];
		tab.tag = 1;
		tab.titleLabel.font = [UIFont systemFontOfSize:19];
		[self addSubview:tab];
		self.numberOfExtraButtons++;
		
		NSString *extendedKeys = [[NSUserDefaults standardUserDefaults] objectForKey:ExtendedKeyboardKeysDefaultsKey];
		for (NSUInteger i = 0; i < [extendedKeys length]; i++) {
			[self addSubview:[self buttonWith:[extendedKeys substringWithRange:NSMakeRange(i, 1)] cropLeft:NO cropRight:NO]];
			self.numberOfExtraButtons++;
		}
		
		UIButton *left = [self buttonWith:@"" cropLeft:NO cropRight:YES];
        [left setImage:[UIImage imageNamed:@"LeftArrow.png"] forState:UIControlStateNormal];
        [left setImage:[UIImage imageNamed:@"LeftArrow.png"] forState:UIControlStateHighlighted];
        left.imageView.contentMode = UIViewContentModeCenter;
		left.tag = 2;
		left.titleLabel.font = [UIFont systemFontOfSize:14];
		left.tintColor = [UIColor blackColor];
		[self addSubview:left];
		self.numberOfExtraButtons++;
		
		UIButton *right = [self buttonWith:@"" cropLeft:YES cropRight:NO];
        [right setImage:[UIImage imageNamed:@"RightArrow.png"] forState:UIControlStateNormal];
        [right setImage:[UIImage imageNamed:@"RightArrow.png"] forState:UIControlStateHighlighted];
        right.imageView.contentMode = UIViewContentModeCenter;
		right.tag = 3;
		right.titleLabel.font = [UIFont systemFontOfSize:14];
		right.tintColor = [UIColor blackColor];
		[self addSubview:right];
		self.numberOfExtraButtons++;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:KeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willRotateToInterfaceOrientation:) name:ApplicationViewWillRotateNotification object:nil];
		
		[self layoutSubviews];
	}    
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
	if ([APP_VIEW_CONTROLLER isHardwareKeyboard]) {
		self.window.alpha = 0;
		self.window.userInteractionEnabled = NO;
	} else {
		self.window.alpha = 1.0;
		self.window.userInteractionEnabled = YES;
	}
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
	if (!newWindow) {
		// when removed restore keyboard visiblity always.
		self.window.alpha = 1.0;
		self.window.userInteractionEnabled = YES;
	}
}

- (void)didMoveToWindow {
	if (self.window) {
		// when moved to new window... hide if there's a hardware keyboard.
		if ([APP_VIEW_CONTROLLER isHardwareKeyboard]) {
			self.window.alpha = 0;
			self.window.userInteractionEnabled = NO;
		} else {
			self.window.alpha = 1.0;
			self.window.userInteractionEnabled = YES;
		}
	}
}

- (void)willRotateToInterfaceOrientation:(NSNotification *)aNotification {
	CGRect f = self.frame;
	UIInterfaceOrientation toOrientation = [[aNotification userInfo][ToOrientation] integerValue];
	if (UIInterfaceOrientationIsPortrait(toOrientation)) {
		f.size = [self sizeThatFits:f.size forOrientation:UIInterfaceOrientationPortrait];
	} else {
		f.size = [self sizeThatFits:f.size forOrientation:UIInterfaceOrientationLandscapeLeft];
	}
	self.frame = f;

	[self setNeedsLayout];
}

@synthesize target;

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

- (void)keyDown {
	[[UIDevice currentDevice] playInputClick];
}

- (void)insertString: (NSString *) insertingString intoTextView: (UITextView *) textView {
    NSRange range = textView.selectedRange;
    NSString *firstHalfString = [textView.text substringToIndex:range.location];
    NSString *secondHalfString = [textView.text substringFromIndex: range.location];
    textView.scrollEnabled = NO;  
    textView.text = [NSString stringWithFormat: @"%@%@%@",
                     firstHalfString,
                     insertingString,
                     secondHalfString];
    range.location += [insertingString length];
    textView.selectedRange = range;
    textView.scrollEnabled = YES;
}

- (void)keyUp:(UIButton *)sender {
	NSString *text = nil;
	
	switch (sender.tag) {
		case 1:
#ifdef TASKPAPER
            if ([target respondsToSelector:@selector(selectedRange)]) {
				NSRange r = NSMakeRange(NSMaxRange(((UITextView *)target).selectedRange), 0);
				r.location = 0;
				((UITextView *)target).selectedRange = r;
			}
            text = @" ";
#else
			text = @"\t";
            UITextView *textView = (id)target;
            [self insertString:text intoTextView:textView];
            text = nil;
#endif
			break;
		case 2: {
			if ([target respondsToSelector:@selector(selectedRange)]) {
				NSRange r = NSMakeRange(((UITextView *)target).selectedRange.location, 0);
				r.location--;
				((UITextView *)target).selectedRange = r;
			}
			break;
		}
		
		case 3: {
			if ([target respondsToSelector:@selector(selectedRange)]) {
				NSRange r = NSMakeRange(NSMaxRange(((UITextView *)target).selectedRange), 0);
				r.location++;
				((UITextView *)target).selectedRange = r;
			}
			break;
		}
		
		default:
			text = sender.titleLabel.text;
			break;
	}
	
	if (text) {
		[target pasteInsertText:text];
	}
}

- (void)layoutSubviews {

	CGFloat minPadding = 10;
	
	CGFloat maxWidth = (self.frame.size.width / self.numberOfExtraButtons) - minPadding;
	CGFloat maxHeight = self.frame.size.height - minPadding;
	CGFloat squareSize = MIN(maxWidth, maxHeight);
	CGFloat padding = (self.frame.size.width - (squareSize * self.numberOfExtraButtons)) / self.numberOfExtraButtons;

	CGFloat x = padding / 2;
	CGFloat y = (self.frame.size.height - squareSize) / 2;
	
	for (UIButton *each in self.subviews) {
		CGRect f = each.frame;

		if ([each isKindOfClass:[UIButton class]]) {
			
			f.size.width = squareSize;
			f.size.height = squareSize;
			f.origin.x = x;
			f.origin.y = y;
			each.frame = CGRectIntegral(f);

			each.titleLabel.font = [UIFont systemFontOfSize:19];
			x += f.size.width + padding;
		}
	}
}

@end
	
@implementation KeyboardButton

@end
	
