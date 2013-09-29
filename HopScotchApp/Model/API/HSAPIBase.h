//
//  HSAPIBase.h
//
//  Created by Maxwell Cabral on 6/17/13.
//

#import <Foundation/Foundation.h>
#import "NSDate+LDIDateTimeStrings.h"

#define API_DEBUG_MODE = 1;

enum K_HTTPMethods {
    K_HTTP_GET,
    K_HTTP_POST,
    K_HTTP_PUT,
    K_HTTP_PATCH,
    K_HTTP_DELETE
};

@interface HSAPIBase : NSObject
@property (weak)                                        id              delegate;
@property (strong, readonly)                            NSDictionary    *response;
@property (strong, readonly)                            NSString        *responseString;
@property (strong, readonly)                            NSURLResponse   *rawResponse;
@property (readonly, getter = getFriendlyResponseError) NSString        *friendlyResponseError;
@property (strong, readonly)                            NSDictionary    *errorMessages;
@property                                               int             apiCallCount;

- (id)initWithDelegate:(id)delegate;
- (void)cancelRequests;
- (void)makeRequestWithMethod:(enum K_HTTPMethods)method successCallback:(SEL)successCallback failureCallback:(SEL)failureCallback andData:(NSDictionary*)parameters;
- (NSString*)getFriendlyResponseError;

//subscripting support. Redirect to the same methods withing self.response
- (id)objectForKeyedSubscript:(id)key;
@end
