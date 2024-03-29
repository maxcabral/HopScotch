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
@synthesize barData;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.barHoursLabel.text = self.barData.hours;
    self.barHappyHourLabel.text = self.barData.happyHour;
    self.barNameLable.text = self.barData.name;
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
    if ([segue.destinationViewController isKindOfClass:[HSBarMenuVC class]]){
        HSBarMenuVC *detailsVC = segue.destinationViewController;
        detailsVC.barData = self.barData;
    }
}

@end
