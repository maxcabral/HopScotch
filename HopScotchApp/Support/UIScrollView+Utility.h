//
//  UIScrollView+Utility.h
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 6/30/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Utility)
- (void)increaseHeight:(CGFloat)height;
- (void)increaseWidth:(CGFloat)width;

- (void)decreaseHeight:(CGFloat)height;
- (void)decreaseWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)newHeight;
- (void)setWidth:(CGFloat)newWidth;
@end
