//
//  HSBeverageAPI.h
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSAPIBase.h"

@interface HSBeverageAPI : HSAPIBase

- (void)searchForBeveragesWithParameters:(NSDictionary*)parameters;

@end
