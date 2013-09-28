//
//  NSString+Empty.m
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 6/29/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)
+ (BOOL)isNilOrEmpty:(NSString*)instance
{
    if (instance == nil || [instance isEmpty]){
        return YES;
    }
    return NO;
}

+ (NSString*)valueOrEmptyString:(id)value
{
    if (value == nil || [value isKindOfClass:[NSNull class]] || ([value isKindOfClass:[NSString class]] && [value isEqualToString:@"<null>"])){
        return @"";
    }
    return value;
}

+ (NSString*)nonEmptyValue:(id)value orSubstituteString:(NSString*)substitute
{
    if ([[NSString valueOrEmptyString:value] isEqualToString:@""]){
        return substitute;
    }
    return value;
}

- (BOOL)isEmpty
{
    return [self isEqualToString:@""];
}

- (BOOL)isEmptyOrWhitespace
{
    return ([self isEqualToString:@""] || ![self matchesExpression:@"\\S"]);
}

- (BOOL)matchesExpression:(NSString*)regularExpression
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error){
        @throw [NSException exceptionWithName:@"Invalid regular exception" reason:[error description] userInfo:nil];
    }

    if (0 < [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])]){
        return YES;
    }
    return NO;
}

- (NSString*)ldiDateStringFormat
{
    if (6 > self.length){
        return self;
    }
    return [NSString stringWithFormat:@"%@-%@-%@",[self substringWithRange:NSMakeRange(0, 2)],[self substringWithRange:NSMakeRange(2, 2)],[self substringWithRange:NSMakeRange(4, 4)]];
}
@end
