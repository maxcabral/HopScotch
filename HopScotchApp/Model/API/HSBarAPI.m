//
//  HSBarAPI.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarAPI.h"

@interface HSBarAPI ()
@property (strong, readwrite)   Class           schemaClass;
@property (strong, readwrite)   NSString        *apiResultSingleIdentifier;
@property (strong, readwrite)   NSString        *apiResultCollectionIdentifier;
@end

@implementation HSBarAPI
@synthesize schemaClass;
@synthesize apiResultCollectionIdentifier;
@synthesize apiResultSingleIdentifier;
- (id)init
{
    self = [super init];
    if (self){
        self.schemaClass                    = [HSBar class];
        self.apiResultSingleIdentifier      = @"record";
        self.apiResultCollectionIdentifier  = @"records";
    }
    return  self;
}

- (void)searchForBarsWithParameters:(NSDictionary*)parameters
{
    [self makeRequestWithMethod:K_HTTP_GET
                            url:[NSString stringWithFormat:@"%@Bar",kSERVER_URL]
                         target:self
                successCallback:@selector(deserializeCollectionOfRecords:)
                failureCallback:@selector(failureDelegatePassthrough:)
                        andData:parameters];
}

@end
