//
//  HSBar.h
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSDictionaryWrapper.h"

@interface HSBar : HSDictionaryWrapper
@property (strong, getter = barID, setter = setBarID:) NSString *barID;
@property (strong, getter = name, setter = setName:) NSString *name;
@property (strong, getter = location, setter = setLocation:) NSString *location;
@property (strong, getter = hours, setter = setHours:) NSString *hours;
@property (strong, getter = happyHour, setter = setHappyHour:) NSString *happyHour;
@end
