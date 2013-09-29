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
@property (strong) IBOutlet UITableView             *barTableView;
@property (strong)          NSMutableArray          *tableViewData;
@end

@implementation HSMainVC
@synthesize searchField;
@synthesize locateMeButton;
@synthesize barTableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableViewData = [[NSMutableArray alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    HSBarAPI *barSearch = [[HSBarAPI alloc] initWithDelegate:self];
    barSearch.successCallback = @selector(barSearchSuccess:);
    barSearch.failureCallback = @selector(barSearchFailure:);
    [barSearch searchForBarsWithParameters:@{}];
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

- (void)barSearchSuccess:(HSBarAPI*)request
{
    self.tableViewData = request[request.apiResultCollectionIdentifier];
    [self.barTableView reloadData];
}

- (void)barSearchFailure:(HSBarAPI*)request
{
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[HSBarVC class]]){
        HSBarVC *detailsVC = segue.destinationViewController;
        detailsVC.barData = self.tableViewData[self.barTableView.indexPathForSelectedRow.row];
    }
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
    [cell applyData:self.tableViewData[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
