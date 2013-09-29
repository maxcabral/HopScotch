//
//  HSBarVC.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarVC.h"

@interface HSBarVC ()
@property (strong) IBOutlet UIImageView         *barImage;
@property (strong) IBOutlet UILabel             *barNameLable;
@property (strong) IBOutlet UILabel             *barHappyHourLabel;
@property (strong) IBOutlet UILabel             *barHappyHourDescriptionLabel;
@property (strong) IBOutlet UILabel             *barHoursLabel;
@property (strong) IBOutlet UILabel             *barHoursDescriptionLabel;
@property (strong) IBOutlet UIButton            *checkInButton;
@property (strong) IBOutlet UIButton            *menuItemsButton;
@end

@implementation HSBarVC
@synthesize barImage;
@synthesize barNameLable;
@synthesize barHappyHourLabel;
@synthesize barHappyHourDescriptionLabel;
@synthesize barHoursLabel;
@synthesize barHoursDescriptionLabel;
@synthesize checkInButton;
@synthesize menuItemsButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkInTUI:(id)sender {
    [[[UIAlertView alloc] initWithTitle:Nil
                                message:@"Thanks for checking in, we'll let your friends know that you're here"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
