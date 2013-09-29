//
//  HSBar.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBar.h"

@implementation HSBar
- (NSString*)barID
{
    return self.internalDictionary[@"barID"];
}

- (void)setBarID:(NSString*)barID
{
    [self.internalDictionary setValue:barID forKey:@"id"];
}

- (NSString*)name
{
    return self.internalDictionary[@"name"];
}

- (void)setName:(NSString*)name
{
    [self.internalDictionary setValue:name forKey:@"name"];
}

- (NSString*)location
{
    return self.internalDictionary[@"location"];
}

- (void)setLocation:(NSString*)location
{
    [self.internalDictionary setValue:location forKey:@"location"];
}

- (NSString*)hours
{
    return self.internalDictionary[@"hours"];
}

- (void)setHours:(NSString*)hours
{
    [self.internalDictionary setValue:hours forKey:@"hours"];
}

- (NSString*)happyHour
{
    return self.internalDictionary[@"happyHour"];
}

- (void)setHappyHour:(NSString*)happyHour
{
    [self.internalDictionary setValue:happyHour forKey:@"happy_hour"];
}
@end
