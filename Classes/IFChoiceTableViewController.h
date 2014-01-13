//
//  IFChoiceTableViewController.h
//  Thunderbird
//
//  Created by Craig Hockenberry on 1/29/09.
//  Copyright 2009 The Iconfactory. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IFCellModel.h"

@class IFChoiceTableViewController;

@interface IFChoiceTableViewController : UITableViewController
{
	SEL updateAction;
	id __weak updateTarget;

	NSString *footerNote;
	
	NSArray *choices;
	NSArray *choiceValues;
	id<IFCellModel> model;
	NSString *key;
}

@property (nonatomic, assign) SEL updateAction;
@property (nonatomic, weak) id updateTarget;

@property (nonatomic, strong) NSString *footerNote;
	
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) NSArray *choiceValues;
@property (nonatomic, strong) id<IFCellModel> model;
@property (nonatomic, strong) NSString *key;

@end

