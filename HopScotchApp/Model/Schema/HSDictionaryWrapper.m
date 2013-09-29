//
//  HSDictionaryWrapper.m
//
//  Created by Maxwell Cabral on 8/2/13.
//

#import "HSDictionaryWrapper.h"

@interface HSDictionaryWrapper ()
{
    NSMutableDictionary *_internalDictionary;
    BOOL                _inStorage;
}
@end

@implementation HSDictionaryWrapper
@synthesize inStorage;
- (id)init
{
    return [self initWithDictonary:[[NSDictionary alloc] init]];
}

- (id)initWithDictonary:(NSDictionary*)data
{
    self = [super init];
    if (self){
        self->_internalDictionary = [data mutableCopy];
        //Assume it's not in storage by default, let the serializers figure it out
        self->_inStorage = NO;
    }
    return self;
}

- (void)dealloc
{
    //Remove the observers
    [self setInStorage:NO];
}

- (NSMutableDictionary*)getInternalDictionary
{
    return _internalDictionary;
}

- (void)setInStorage:(BOOL)value
{
    if (value == YES){
        //Set observers to monitor changes. If anything changes, we'll want to know so we can store it later.
        for (id key in self->_internalDictionary) {
            [self->_internalDictionary addObserver:self forKeyPath:[key description] options:0 context:(__bridge void *)(key)];
        }
    } else {
        for (id key in self->_internalDictionary) {
            @try {
                [self->_internalDictionary removeObserver:self forKeyPath:[key description] context:(__bridge void *)(key)];
            }
            @catch (NSException *exception) {
                NSLog(@"Issue removing observer: %@",exception.description);
            }
        }
    }
    self->_inStorage = value;
}

- (BOOL)inStorage{
    return self->_inStorage;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.inStorage = NO;
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[self class] allocWithZone:zone];
    copy = [(HSDictionaryWrapper*)copy initWithDictonary:[self->_internalDictionary copy]];
    ((HSDictionaryWrapper*)copy)->_inStorage = self->_inStorage;
    return copy;
}

- (void)shallowCopy:(HSDictionaryWrapper*)target
{
    if (target){
        [self->_internalDictionary addEntriesFromDictionary:target->_internalDictionary];
        self->_inStorage = target->_inStorage;
    }
}

@end
