//
//  NSString+WebStrings.m
//
//  Created by Maxwell Cabral
//

#import "NSString+WebStrings.h"

@implementation NSString (WebStrings)
/******
 uriEncode
 
 Returns a Uri encoded version of this NSString
 ******/
-(NSString*)uriEncode
{
    return (NSString *)CFBridgingRelease(
                CFURLCreateStringByAddingPercentEscapes(
                    NULL,
                   (__bridge CFStringRef) self,
                    NULL,
                    CFSTR("!*'();:@&=+$,/?%#[]"),
                    kCFStringEncodingUTF8
                 )
            );
}

@end
