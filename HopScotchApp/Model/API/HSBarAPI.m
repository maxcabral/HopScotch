//
//  HSBarAPI.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarAPI.h"

@implementation HSBarAPI

- (id)init
{
    
}

- (void)searchForBarsWithParameters:(NSDictionary*)parameters
{
    [self makeRequestWithMethod:K_HTTP_GET
                         target:self
                successCallback:@selector(deserializeCollectionOfRecords:)
                failureCallback:@selector(failureDelegatePassthrough:)
                        andData:parameters];
}

@end
