//
//  PathViewWrapper.h
//  PlainText
//
//  Created by Jesse Grosjean on 5/31/11.
//

#import <Foundation/Foundation.h>

@class PathView;
@class Button;

@interface PathViewWrapper : UIView {
	PathView *__weak pathView;
	Button *__weak popupMenuButton;
}

@property (weak, nonatomic, readonly) PathView *pathView;
@property (weak, nonatomic, readonly) Button *popupMenuButton;

@end
