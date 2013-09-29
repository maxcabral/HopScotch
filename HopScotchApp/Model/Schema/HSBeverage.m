//
//  HSBeverage.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBeverage.h"

@implementation HSBeverage
- (NSString*)beverageID
{
    return self.internalDictionary[@"beverageID"];
}

- (void)setBeverageID:(NSString*)beverageID
{
    [self.internalDictionary setValue:beverageID forKey:@"id"];
}

- (NSString*)barID
{
    return self.internalDictionary[@"barID"];
}

- (void)setBarID:(NSString*)barID
{
    [self.internalDictionary setValue:barID forKey:@"bar_id"];
}

- (NSString*)drinkType
{
    return self.internalDictionary[@"drinkType"];
}

- (void)setDrinkType:(NSString*)drinkType
{
    [self.internalDictionary setValue:drinkType forKey:@"drink_type"];
}

- (NSString*)drinkSubType
{
    return self.internalDictionary[@"drinkSubType"];
}

- (void)setDrinkSubType:(NSString*)drinkSubType
{
    [self.internalDictionary setValue:drinkSubType forKey:@"drink_sub_type"];
}

- (NSString*)name
{
    return self.internalDictionary[@"name"];
}

- (void)setName:(NSString*)name
{
    [self.internalDictionary setValue:name forKey:@"name"];
}

- (NSString*)drinkStyle
{
    return self.internalDictionary[@"drinkStyle"];
}

- (void)setDrinkStyle:(NSString*)drinkStyle
{
    [self.internalDictionary setValue:drinkStyle forKey:@"drink_style"];
}

- (NSString*)ingredients
{
    return self.internalDictionary[@"ingredients"];
}

- (void)setIngredients:(NSString*)ingredients
{
    [self.internalDictionary setValue:ingredients forKey:@"ingredients"];
}

- (NSString*)priceServing
{
    return self.internalDictionary[@"priceServing"];
}

- (void)setPriceServing:(NSString*)priceServing
{
    [self.internalDictionary setValue:priceServing forKey:@"price_serving"];
}

- (NSString*)priceUnit
{
    return self.internalDictionary[@"priceUnit"];
}

- (void)setPriceUnit:(NSString*)priceUnit
{
    [self.internalDictionary setValue:priceUnit forKey:@"price_unit"];
}

- (NSString*)ABV
{
    return self.internalDictionary[@"ABV"];
}

- (void)setABV:(NSString*)ABV
{
    [self.internalDictionary setValue:ABV forKey:@"abv"];
}

@end
