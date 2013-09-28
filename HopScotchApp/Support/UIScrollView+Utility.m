//
//  UIScrollView+Utility.m
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 6/30/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import "UIScrollView+Utility.h"

@implementation UIScrollView (Utility)
- (void)increaseHeight:(CGFloat)height
{
    [self setContentSize:CGSizeMake(self.contentSize.width, self.contentSize.height + height)];
}

- (void)increaseWidth:(CGFloat)width
{
    [self setContentSize:CGSizeMake(self.contentSize.width + width, self.contentSize.height)];
}

- (void)decreaseHeight:(CGFloat)height
{
    [self setContentSize:CGSizeMake(self.contentSize.width, self.contentSize.height - height)];
}

- (void)decreaseWidth:(CGFloat)width
{
    [self setContentSize:CGSizeMake(self.contentSize.width - width, self.contentSize.height)];
}

- (void)setHeight:(CGFloat)newHeight
{
    [self setContentSize:CGSizeMake(self.contentSize.width, newHeight)];
}

- (void)setWidth:(CGFloat)newWidth
{
    [self setContentSize:CGSizeMake(newWidth, self.contentSize.height)];
}
@end
