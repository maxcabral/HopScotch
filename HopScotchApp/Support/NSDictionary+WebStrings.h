//
//  NSDictionary+WebStrings.h
//
//  Created by Maxwell Cabral
//

#import <Foundation/Foundation.h>
#import "NSString+WebStrings.h"

@interface NSDictionary (WebStrings)
/******
 postBody
 
 Returns a Uri encoded POST body string of this NSDictionary's contents
 ******/
-(NSString*)queryString;

/******
 queryString
 
 Returns a Uri encoded query string of this NSDictionary's contents
 ******/
-(NSString*)postBody;
@end
