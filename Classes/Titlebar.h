//
//  TitleBar.h
// PlainText
//
//  Created by Jesse Grosjean on 6/23/10.
//

#import "Bar.h"

@class PathViewWrapper;

@interface Titlebar : Bar {
	PathViewWrapper *__weak pathViewWrapper;
	UIButton *leftButton;
	CGFloat originalLeftWidth;
	UIEdgeInsets originalLeftInsets;
	UIButton *rightButton;
	CGFloat originalRightWidth;
	UIEdgeInsets originalRightInsets;
}

@property (weak, nonatomic, readonly) PathViewWrapper *pathViewWrapper;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

- (void)setPathViewWrapper:(PathViewWrapper *)aPathViewWrapper becomeFirstResponder:(BOOL)becomeFirstResponder;

@end
