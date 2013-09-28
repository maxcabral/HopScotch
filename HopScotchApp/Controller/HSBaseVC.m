//
//  HSBaseVC.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBaseVC.h"

@interface HSBaseVC ()

@end

@implementation HSBaseVC
@synthesize dismissKeyboardGesture;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.dismissKeyboardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopEditing)];
    self.dismissKeyboardGesture.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%@",[touch.view class]);
    // Disallow recognition of tap gestures in the segmented control.
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    } else if ([touch.view.superview isKindOfClass:[UIToolbar class]]) {
        return NO;
    }
    return YES;
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:dismissKeyboardGesture];
}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:dismissKeyboardGesture];
}

@end
