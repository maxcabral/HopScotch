//
//  HSAPIBase.m
//
//  Created by Maxwell Cabral on 6/17/13.
//

#import "HSAPIBase.h"
#import "NSDictionary+WebStrings.h"

@interface HSAPIBase()
{
    NSOperationQueue *queue;
    double           timeoutInterval;
}
@property (strong) NSString *responseString;
@property (strong) NSDictionary *response;
@property (strong) NSURLResponse *rawResponse;
@end

@implementation HSAPIBase
@synthesize delegate, response, responseString, rawResponse, errorMessages;
@synthesize apiCallCount;

- (id)init
{
    self = [super init];
    if (self){
        queue = [[NSOperationQueue alloc] init];
        timeoutInterval = 60.0;
        self.apiCallCount = 0;
    }
    
    return self;
}

- (id)initWithDelegate:(id)_delegate
{
    self = [self init];
    if (self){
        self.delegate = _delegate;
    }
    return self;
}

- (NSString*)httpMethodEnumToString:(enum K_HTTPMethods)method
{
    switch (method) {
        case K_HTTP_GET:
            return @"GET";
            break;
        case K_HTTP_POST:
            return @"POST";
            break;
        case K_HTTP_PUT:
            return @"PUT";
            break;
        case K_HTTP_PATCH:
            return @"PATCH";
            break;
        case K_HTTP_DELETE:
            return @"DELETE";
            break;
        default:
            @throw [[NSException alloc] initWithName:@"Unknown HTTP Method" reason:@"HTTP Method not recognized" userInfo:nil];
            break;
    }
}

- (NSString*)getFriendlyResponseError
{
    NSString *error = [self.response objectForKey:@"success"];
    if ([NSString isNilOrEmpty:error]){
        error = @"";
    } else {
        error = [self.errorMessages objectForKey:error];
    }
    
    return error;
}

//Pass through subscript operator
- (id)objectForKeyedSubscript:(id)key
{
    return [self.response objectForKey:key];
}

- (void)cancelRequests
{
    [self->queue cancelAllOperations];
}

- (void)makeRequestWithMethod:(enum K_HTTPMethods)method successCallback:(SEL)successCallback failureCallback:(SEL)failureCallback andData:(NSDictionary*)sentParameters;
{
#ifdef K_LDI_API_DEBUG_MODE
    NSString *reqUri = @"http://wksystems.net/epres/api/index";
#else
    NSString *reqUri = @"http://epres.ldirx.com/api/index";
#endif
    
    NSMutableDictionary *parameters = [sentParameters mutableCopy];
    [parameters setObject:@"json" forKey:@"returntype"];
    
    if (method == K_HTTP_GET || method == K_HTTP_DELETE){
        reqUri = [NSString stringWithFormat:@"%@?%@",reqUri,[parameters queryString]];
    }
    
    //AsynchronousRequest to grab the data
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqUri]];
    [request setTimeoutInterval:self->timeoutInterval];
    [request setHTTPMethod:[self httpMethodEnumToString:method]];
    
    if (method == K_HTTP_POST || method == K_HTTP_PUT || method == K_HTTP_PATCH) {
        NSString* reqString = [parameters postBody];
        NSData *ReqData = [NSData dataWithBytes: [reqString UTF8String] length: [reqString length]];
        [request setHTTPBody:ReqData];
    }
    
    [self sendAsyncRequest:request successCallback:successCallback failureCallback:failureCallback];
}

- (void)sendAsyncRequest:(NSMutableURLRequest*)request successCallback:(SEL)successCallback failureCallback:(SEL)failureCallback
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.apiCallCount++;
    [NSURLConnection sendAsynchronousRequest:request queue:self->queue completionHandler:^(NSURLResponse *httpResponse, NSData *data, NSError *error)
     {
         self.rawResponse = httpResponse;
         
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         if ([data length] > 0 && error == nil){
             self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSError *error;
             self.response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
                          
             if (self.response && delegate)
             {
                 NSString *success = [self.response objectForKey:@"success"];
                 if (success == nil || [success isEqualToString:@"FALSE"]){
                     [delegate performSelectorOnMainThread:failureCallback
                                                 withObject:self
                                              waitUntilDone:NO];
                     return;
                 }
                 
                 
                 [delegate performSelectorOnMainThread:successCallback
                                            withObject:self
                                         waitUntilDone:NO];
                 return;
             } else {
                 self.responseString = @"bad response";
             }
         }
         else if ([data length] == 0 && error == nil)
         {
             //empty data
             self.responseString = @"no data";
         }
         //used this NSURLErrorTimedOut from foundation error responses
         else if (error != nil && error.code == NSURLErrorTimedOut)
         {
             //timeout
             self.responseString = @"timeout";
         }
         else if (error != nil)
         {
             //generic error
             self.responseString = @"generic error";
         }
         //If its a comm error, call the callback without a message.  The callback will check sender.lastResponse
         //Call on main thread to prevent lockups and prevent a slow context switch.
         if (delegate){
             [delegate performSelectorOnMainThread:failureCallback
                                        withObject:self
                                     waitUntilDone:NO];
         }
         return;
     }];
}
@end