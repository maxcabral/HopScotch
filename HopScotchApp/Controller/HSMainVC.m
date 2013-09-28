//
//  HSViewController.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSMainVC.h"

@interface HSMainVC ()
@property (strong) IBOutlet UITextField *searchField;
@end

@implementation HSMainVC
@synthesize searchField;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)stopEditing
{
    [super stopEditing];
    [self.searchField resignFirstResponder];
}

@end
