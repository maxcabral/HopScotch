//
//  UIViewController+GestureRecognizerMethods.m
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 6/24/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import "UIViewController+GestureRecognizerMethods.h"

@implementation UIViewController (GestureRecognizerMethods)
- (void)stopEditing
{
    [self.view endEditing:YES];
}
@end
