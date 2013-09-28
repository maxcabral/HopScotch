//
//  UIViewController+Utility.m
//
//  Created by Maxwell Cabral.
//

#import "UIViewController+Utility.h"

@implementation UIViewController (Utility)
- (MC_IOS_DEVICE_AND_ORIENTATION)detectDeviceAndOrientation
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
            if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
                return MC_iOSFourInchLandscape;
            }
            return MC_iOSFourInchPortrait;
        } else {
            /*Do iPhone Classic stuff here.*/
            if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
                return MC_iOSThreeInchLandscape;
            }
            return MC_iOSThreeInchPortrait;
        }
    } else {
        /*Do iPad stuff here.*/
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
            return MC_iOSiPadLandscape;
        }
        return MC_iOSiPadPortrait;
    }
}
@end
