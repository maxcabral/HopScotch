//
//  UIViewController+Utility.h
//  LDIPharmacy
//
//  Created by Maxwell Cabral on 6/30/13.
//  Copyright (c) 2013 LDI Pharmacy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MC_iOSThreeInchPortrait,
    MC_iOSThreeInchLandscape,
    MC_iOSFourInchPortrait,
    MC_iOSFourInchLandscape,
    MC_iOSiPadPortrait,
    MC_iOSiPadLandscape,
} MC_IOS_DEVICE_AND_ORIENTATION;

@interface UIViewController (Utility)
- (MC_IOS_DEVICE_AND_ORIENTATION)detectDeviceAndOrientation;
@end
