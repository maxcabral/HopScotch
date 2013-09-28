//
//  MCObservableMutableDictionary.m
//
//  Created by Maxwell Cabral.
//  Copyright (c) 2013 Maxwell Cabral. All rights reserved.
//

#import "MCObservableMutableDictionary.h"
#import <objc/runtime.h>

@interface MCObservableMutableDictionary ()
@property (strong, nonatomic) NSMutableDictionary *backingDictionary;
@property (strong, nonatomic) NSMutableArray      *observers;
@end

@implementation MCObservableMutableDictionary
@synthesize backingDictionary, observers, observationShouldBeIgnored;

NSString *DescriptionForObject(NSObject *object, id locale, NSUInteger indent)
{
	NSString *objectString;
	if ([object isKindOfClass:[NSString class]])
	{
		objectString = (NSString *)object;
	}
	else if ([object respondsToSelector:@selector(descriptionWithLocale:indent:)])
	{
		objectString = [(NSDictionary *)object descriptionWithLocale:locale indent:indent];
	}
	else if ([object respondsToSelector:@selector(descriptionWithLocale:)])
	{
		objectString = [(NSSet *)object descriptionWithLocale:locale];
	}
	else
	{
		objectString = [object description];
	}
	return objectString;
}

- (id)init
{
	return [self initWithCapacity:0];
}

- (id)initWithCapacity:(NSUInteger)capacity
{
	self = [super init];
	if (self != nil)
	{
		self.backingDictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        self.observers = [[NSMutableArray alloc] init];
        self.observationShouldBeIgnored = NO;
	}
	return self;
}

- (id)copy
{
	return [self mutableCopy];
}

- (id)mutableCopy
{
    MCObservableMutableDictionary *copy = [[MCObservableMutableDictionary alloc] init];
    copy.backingDictionary = [backingDictionary mutableCopy];
    return copy;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self mutableCopyWithZone:zone];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    MCObservableMutableDictionary *copy = [[MCObservableMutableDictionary alloc] init];
    copy.backingDictionary = [backingDictionary copyWithZone:zone];
    return copy;
}

- (NSArray*)allValues
{
    return [self.backingDictionary allValues];
}

- (NSArray*)allKeys
{
    return [self.backingDictionary allKeys];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained *)stackbuf count:(NSUInteger)len
{
    return [self.backingDictionary countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (id)objectForKeyedSubscript:(id)key
{
    return [self.backingDictionary objectForKey:key];
}

- (void)setObject:(id)newValue forKeyedSubscript:(id)key
{
    [self setObject:newValue forKey:key];
}

- (void)removeObjectForKey:(id)aKey
{  
    [self willChangeValueForKey:kMCObservableDictionaryKVOAnyChange];
    [self.backingDictionary removeObjectForKey:aKey];
    [self didChangeValueForKey:kMCObservableDictionaryKVOAnyChange];
    
    for (NSValue *observerWrapper in self.observers) {
        NSObject *possibleObserver = observerWrapper.nonretainedObjectValue;
        if (possibleObserver == nil){
            [self.observers removeObject:observerWrapper];
        } else {
            [self.backingDictionary removeObserver:possibleObserver forKeyPath:aKey];
        }
    }
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    for (NSValue *observerWrapper in self.observers) {
        NSObject *possibleObserver = observerWrapper.nonretainedObjectValue;
        if (possibleObserver == nil){
            [self.observers removeObject:observerWrapper];
        } else {
            [self.backingDictionary addObserver:possibleObserver forKeyPath:aKey options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        }
    }
    
    [self willChangeValueForKey:kMCObservableDictionaryKVOAnyChange];
    [self.backingDictionary setObject:anObject forKey:aKey];
    [self didChangeValueForKey:kMCObservableDictionaryKVOAnyChange];
}

- (NSUInteger)count
{
	return [self.backingDictionary count];
}

- (id)objectForKey:(id)aKey
{
	return [self.backingDictionary objectForKey:aKey];
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    NSUInteger index = [self.observers indexOfObjectPassingTest:^(NSValue *obj, NSUInteger idx, BOOL *stop){
        if (obj.nonretainedObjectValue == observer){
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (index == NSNotFound){
        [self.observers addObject:[NSValue valueWithNonretainedObject:observer]];
    }
    
    for (NSString *key in [self.backingDictionary allKeys]) {
        [self.backingDictionary addObserver:observer forKeyPath:key options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    
    [super addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    NSUInteger index = [self.observers indexOfObjectPassingTest:^(NSValue *obj, NSUInteger idx, BOOL *stop){
        if (obj.nonretainedObjectValue == observer){
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (index != NSNotFound){
        [self.observers removeObjectAtIndex:index];
    }
    
    for (NSString *key in [self.backingDictionary allKeys]) {
        [self.backingDictionary removeObserver:observer forKeyPath:key];
    }
    
    
    
    [super removeObserver:observer forKeyPath:keyPath];
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context
{
    NSUInteger index = [self.observers indexOfObjectPassingTest:^(NSValue *obj, NSUInteger idx, BOOL *stop){
        if (obj.nonretainedObjectValue == observer){
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (index != NSNotFound){
        [self.observers removeObjectAtIndex:index];
    }
    
    for (NSString *key in [self.backingDictionary allKeys]) {
        [self.backingDictionary removeObserver:observer forKeyPath:key context:nil];
    }
    [super removeObserver:observer forKeyPath:keyPath context:context];
}

- (void)removeAllObservers
{
    for (id observer in self.observers) {
        @try {
            [self removeObserver:observer forKeyPath:@"kMCObservableDictionaryKVOAnyChange" context:nil];
        }
        @catch (NSException *exception) {

        }
        for (NSString *key in self.backingDictionary) {
            @try {
                [self.backingDictionary removeObserver:observer forKeyPath:key context:nil];
            }
            @catch (NSException *exception) {

            }
        }
    }
}

/********
 
 Methods to help us pretend to be an NSMutableDictionary
 
 ********/
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.backingDictionary respondsToSelector:anInvocation.selector]){
        [anInvocation invokeWithTarget:self.backingDictionary];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [self.backingDictionary methodSignatureForSelector:selector];
    }
    return signature;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL responds = NO;
    if ([super respondsToSelector:aSelector] || [self respondsToSelector:aSelector] || [self.backingDictionary respondsToSelector:aSelector]) {
        responds = YES;
    }
    return responds;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    BOOL isKind = NO;
    if ([self isKindOfClass:aClass] || [self.backingDictionary isKindOfClass:aClass]) {
        isKind = YES;
    }
    return isKind;
}

+ (BOOL)supportsSecureCoding;
{
    return [NSMutableDictionary supportsSecureCoding];
}
@end
