//
//  NSDictionary+WebStrings.m
//
//  Created by Maxwell Cabral
//

#import "NSDictionary+WebStrings.h"

@implementation NSDictionary (WebStrings)

/******
 postBody
 
 Returns a Uri encoded POST body string of this NSDictionary's contents
 ******/
-(NSString*)postBody
{
    if (self.count == 0){
        return @"";
    }
    
    NSMutableString *sb = [[NSMutableString alloc] init];
    int keycount = 1;
    for (NSString *key in self) {
        NSString *val = [self objectForKey:key];
        NSAssert([val isKindOfClass:[NSString class]], @"%@ should be kind of class %@", val, [[NSString class] description]);
        
        if (val != nil && ![val isEqualToString:@""]){
            [sb appendString:[key uriEncode]];
            [sb appendString:@"="];
            [sb appendString:[val uriEncode]];
            if (keycount++ != self.count) {
                [sb appendString:@"&"];
            }
        }
    }
    return [sb copy];
}

/******
 queryString
 
 Returns a Uri encoded query string of this NSDictionary's contents
 ******/
-(NSString*)queryString
{
    if (self.count == 0){
        return @"";
    }
    
    NSMutableString *sb = [[NSMutableString alloc] initWithString:@"?"];
    int keycount = 1;
    for (NSString *key in self) {
        NSString *val = [self objectForKey:key];
        NSAssert([val isKindOfClass:[NSString class]], @"%@ should be kind of class %@", val, [[NSString class] description]);
        
        if (val != nil && ![val isEqualToString:@""]){
            [sb appendString:[key uriEncode]];
            [sb appendString:@"="];
            [sb appendString:[val uriEncode]];
            if (keycount++ != self.count) {
                [sb appendString:@"&"];
            }
        }
    }
    return [sb copy];
}

@end
