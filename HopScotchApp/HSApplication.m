//
//  HSApplication.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSApplication.h"

@implementation HSApplication
@synthesize stash;

- (id)init
{
    self = [super init];
    if (self){
        self.stash = [[NSMutableDictionary alloc] init];
    }
    return self;
}
@end

@implementation UIApplication (HSApplication)

+ (HSApplication *)sharedHSApplication
{
    static HSApplication *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HSApplication alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

@end
