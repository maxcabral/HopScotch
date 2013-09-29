//
//  HSAPIBase.h
//
//  Created by Maxwell Cabral on 6/17/13.
//

#import <Foundation/Foundation.h>
// #import "NSDate+LDIDateTimeStrings.h"

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
@property                                               SEL             successCallback;
@property                                               SEL             failureCallback;
@property (strong, readonly)                            Class           schemaClass;
@property (strong, readonly)                            NSString        *apiResultSingleIdentifier;
@property (strong, readonly)                            NSString        *apiResultCollectionIdentifier;
@property (strong, readonly)                            NSDictionary    *response;
@property (strong, readonly)                            NSString        *responseString;
@property (strong, readonly)                            NSURLResponse   *rawResponse;
@property (readonly, getter = getFriendlyResponseError) NSString        *friendlyResponseError;
@property (strong, readonly)                            NSDictionary    *errorMessages;
@property                                               int             apiCallCount;

- (id)initWithDelegate:(id)delegate;
- (void)cancelRequests;
- (void)makeRequestWithMethod:(enum K_HTTPMethods)method url:(NSString*)url target:(id)target successCallback:(SEL)successCallback failureCallback:(SEL)failureCallback andData:(NSDictionary*)parameters;
- (NSString*)getFriendlyResponseError;

- (void)deserializeCollectionOfRecords:(HSAPIBase*)request;
- (void)deserializeSingleRecord:(HSAPIBase*)request;
- (void)failureDelegatePassthrough:(HSAPIBase*)request;

//subscripting support. Redirect to the same methods withing self.response
- (id)objectForKeyedSubscript:(id)key;
@end
