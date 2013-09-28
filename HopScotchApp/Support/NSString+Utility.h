//
//  NSString+Empty.h
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 6/29/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)
+ (BOOL)isNilOrEmpty:(NSString*)instance;
+ (NSString*)valueOrEmptyString:(id)value;
+ (NSString*)nonEmptyValue:(id)value orSubstituteString:(NSString*)substitute;
- (BOOL)isEmpty;
- (BOOL)isEmptyOrWhitespace;
- (BOOL)matchesExpression:(NSString*)regularExpression;
- (NSString*)ldiDateStringFormat;
@end
