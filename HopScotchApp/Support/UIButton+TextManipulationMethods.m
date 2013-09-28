//
//  UIButton+TextManipulationMethods.m
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 7/24/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import "UIButton+TextManipulationMethods.h"

@implementation UIButton (TextManipulationMethods)
- (void)setTitleForAllStates:(NSString*)title
{
    [self setTitle:title forState:UIControlStateDisabled];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateApplication];
}

- (void)setBackgroundImageForAllStates:(UIImage*)image
{
    [self setBackgroundImage:image forState:UIControlStateDisabled];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:image forState:UIControlStateSelected];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
    [self setBackgroundImage:image forState:UIControlStateApplication];
}
@end
