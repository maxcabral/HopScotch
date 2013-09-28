//
//  MCObservableMutableDictionary.h
//
//  Created by Maxwell Cabral.
//  Copyright (c) 2013 Maxwell Cabral. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kMCObservableDictionaryKVOAnyChange = @"anyKey";

@interface MCObservableMutableDictionary : NSObject <NSCopying, NSFastEnumeration>
@property (strong, readonly, nonatomic) NSMutableDictionary *backingDictionary;
@property BOOL observationShouldBeIgnored;
- (id)init;
- (id)initWithCapacity:(NSUInteger)capacity;
- (id)copy;
- (id)mutableCopy;
- (id)copyWithZone:(NSZone *)zone;
- (id)mutableCopyWithZone:(NSZone *)zone;
- (NSArray*)allValues;
- (NSArray*)allKeys;
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained *)stackbuf count:(NSUInteger)len;
- (void)removeObjectForKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id)aKey;
- (id)objectForKey:(id)aKey;
- (NSUInteger)count;

- (void)setObject:(id)newValue forKeyedSubscript:(id)key;
- (id)objectForKeyedSubscript:(id)key;

- (void)removeAllObservers;

+ (BOOL)supportsSecureCoding;
@end
