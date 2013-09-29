//
//  HSBeverage.h
//  HopScotch
//
//  Created by Maxwell Cabral on 9/29/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSDictionaryWrapper.h"

@interface HSBeverage : HSDictionaryWrapper
@property (strong, getter = beverageID, setter = setBeverageID:) NSString *beverageID;
@property (strong, getter = barID, setter = setBarID:) NSString *barID;
@property (strong, getter = drinkType, setter = setDrinkType:) NSString *drinkType;
@property (strong, getter = drinkSubType, setter = setDrinkSubType:) NSString *drinkSubType;
@property (strong, getter = name, setter = setName:) NSString *name;
@property (strong, getter = drinkStyle, setter = setDrinkStyle:) NSString *drinkStyle;
@property (strong, getter = ingredients, setter = setIngredients:) NSString *ingredients;
@property (strong, getter = priceServing, setter = setPriceServing:) NSString *priceServing;
@property (strong, getter = priceUnit, setter = setPriceUnit:) NSString *priceUnit;
@property (strong, getter = ABV, setter = setABV:) NSString *ABV;
@end
