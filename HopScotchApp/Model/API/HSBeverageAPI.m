//
//  HSBeverageAPI.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBeverageAPI.h"

@interface HSBeverageAPI ()
@property (strong, readwrite)   Class           schemaClass;
@property (strong, readwrite)   NSString        *apiResultSingleIdentifier;
@property (strong, readwrite)   NSString        *apiResultCollectionIdentifier;
@end

@implementation HSBeverageAPI
@synthesize schemaClass;
@synthesize apiResultCollectionIdentifier;
@synthesize apiResultSingleIdentifier;
- (id)init
{
    self = [super init];
    if (self){
        self.schemaClass                    = [HSBeverage class];
        self.apiResultSingleIdentifier      = @"record";
        self.apiResultCollectionIdentifier  = @"records";
    }
    return  self;
}

- (void)searchForBeveragesWithParameters:(NSDictionary*)parameters
{
    [self makeRequestWithMethod:K_HTTP_GET
                            url:[NSString stringWithFormat:@"%@Beverage",kSERVER_URL]
                         target:self
                successCallback:@selector(deserializeCollectionOfRecords:)
                failureCallback:@selector(failureDelegatePassthrough:)
                        andData:parameters];
}

@end
