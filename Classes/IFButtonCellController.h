//
//  IFButtonCellController.h
//  Thunderbird
//
//	Created by Craig Hockenberry on 1/29/09.
//	Copyright 2009 The Iconfactory. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IFCellController.h"

@interface IFButtonCellController : NSObject <IFCellController>
{
	NSString *label;
	SEL action;
	id target;

	UITableViewCellAccessoryType accessoryType;
	UIView *accessoryView;
    NSTextAlignment textAlignment;
}


@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic) UIView *accessoryView;

- (id)initWithLabel:(NSString *)newLabel withAction:(SEL)newAction onTarget:(id)newTarget;
- (id)initWithLabel:(NSString *)newLabel withAccessoryView:(UIView *)newAccessoryView withAction:(SEL)newAction onTarget:(id)newTarget;

@end
