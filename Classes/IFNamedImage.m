//
//  IFNamedImage.m
//  Thunderbird
//
//  Created by Craig Hockenberry on 1/30/09.
//  Copyright 2009 The Iconfactory. All rights reserved.
//

#import "IFNamedImage.h"


@implementation IFNamedImage

@synthesize image, name;

+ (IFNamedImage *)image:(UIImage *)newImage withName:(NSString *)newName;
{
	return [[IFNamedImage alloc] initWithImage:newImage andName:newName];
}

- (id)initWithImage:(UIImage *)newImage andName:(NSString *)newName
{
	self = [super init];
	if (self != nil)
	{
		name = newName;
		image = newImage;
	}
	return self;
}


@end
