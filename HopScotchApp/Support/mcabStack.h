//
//  mcabStack.h
//  Maxwell Cabral
//
//  mcabStack: A NSMutableArray subclass with additional locking stack semantics.
//
//  Created by Maxwell Cabral
//  Copyright (c) 2013 Maxwell Cabral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mcabStack : NSMutableArray
- (void)push:(id)anObject;
- (id)pop;
- (id)top;
- (void)empty;
@end
