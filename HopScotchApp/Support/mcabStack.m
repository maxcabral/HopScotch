//
//  mcabStack.m
//  Maxwell Cabral
//
//  Created by Maxwell Cabral
//  Copyright (c) 2013 Maxwell Cabral. All rights reserved.
//

#import "mcabStack.h"

@implementation mcabStack
- (void)push:(id)anObject
{
    @synchronized(self){
        [self addObject:anObject];
    }
}

- (id)pop
{
    @synchronized(self){
        id retVal = [self lastObject];
        [super removeLastObject];
        return retVal;
    }
}

- (id)top
{
    @synchronized(self){
        return [self lastObject];
    }
}

- (void)empty
{
    @synchronized(self){
        [self removeAllObjects];
    }
}
@end
