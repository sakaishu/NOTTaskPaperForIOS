//
//  IFTemporaryModel.m
//  Thunderbird
//
//  Created by Craig Hockenberry on 1/30/09.
//  Copyright 2009 The Iconfactory. All rights reserved.
//

#import "IFTemporaryModel.h"

@implementation IFTemporaryModel

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		_temporaryModel = [NSMutableDictionary dictionary];
	}
	return self;
}

- (id)initWithDictionary:(NSMutableDictionary *)dictionary
{
	self = [super init];
	if (self != nil)
	{
		_temporaryModel = [NSMutableDictionary dictionaryWithDictionary:dictionary];
	}
	return self;
}



- (void)setObject:(id)value forKey:(NSString *)key
{
	[_temporaryModel setValue:value forKey:key];
}

- (id)objectForKey:(NSString *)key
{
	return [_temporaryModel valueForKey:key];
}

- (NSMutableDictionary *)dictionary
{
//	return [NSMutableDictionary dictionaryWithDictionary:_temporaryModel];
	return _temporaryModel;
}

@end
