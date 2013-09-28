//
//  HSBarItemDetailsVC.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarItemDetailsVC.h"

@interface HSBarItemDetailsVC ()
@property (strong) IBOutlet UIImageView     *barItemImage;
@property (strong) IBOutlet UILabel         *barItemNameLabel;
@property (strong) IBOutlet UILabel         *barItemTypeLabel;
@property (strong) IBOutlet UILabel         *barItemInfoLabel;
@property (strong) IBOutlet UITextView      *barItemDescriptionTextView;
@property (strong) IBOutlet UIButton        *checkinButton;
@end

@implementation HSBarItemDetailsVC
@synthesize barItemImage;
@synthesize barItemNameLabel;
@synthesize barItemTypeLabel;
@synthesize barItemInfoLabel;
@synthesize barItemDescriptionTextView;
@synthesize checkinButton;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkinButtonTUI:(UIButton *)sender {

}

@end
