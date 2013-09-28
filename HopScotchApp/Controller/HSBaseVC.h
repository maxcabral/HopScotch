//
//  HSBaseVC.h
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSBaseVC : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate>
@property (strong) UIGestureRecognizer *dismissKeyboardGesture;
@end
