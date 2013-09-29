//
//  HSViewController.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSMainVC.h"

@interface HSMainVC ()
@property (strong) IBOutlet UITextField             *searchField;
@property (strong) IBOutlet UIButton                *locateMeButton;
@property (strong)          NSMutableDictionary     *tableViewData;
@end

@implementation HSMainVC
@synthesize searchField;
@synthesize locateMeButton;
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

- (IBAction)searchButtonTUI:(id)sender {

}

- (IBAction)locateMeTUI:(id)sender {

}

/********
 UITableView Data Source/Delegate
 ********/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSBarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"barCell"];
    if (cell == nil)
    {
        cell = [[HSBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"barCell"];
    }
    [cell setupView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
