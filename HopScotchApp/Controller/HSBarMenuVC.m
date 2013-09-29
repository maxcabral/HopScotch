//
//  HSBarMenuVC.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarMenuVC.h"

@interface HSBarMenuVC ()
@property (strong) IBOutlet UITabBar            *drinkTypeBar;
@property (strong) IBOutlet UITableView         *barItemsTableView;
@property (strong)          NSMutableDictionary *barTableData;
@property (strong)          NSArray             *barTableIdentifiers;
@property (strong)          NSString            *selectedIdentifier;
@end

@implementation HSBarMenuVC
@synthesize barTableData;
@synthesize barTableIdentifiers;
@synthesize drinkTypeBar;
@synthesize selectedIdentifier;
@synthesize barData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self ctor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self ctor];
    }
    return self;
}

- (void)ctor
{
    self.barTableData = [[NSMutableDictionary alloc] init];
    self.barTableIdentifiers = @[@"Beer",@"Liquor",@"Wine"];
    self.selectedIdentifier = self.barTableIdentifiers[0];
    for (NSString *key in self.barTableIdentifiers) {
        [self.barTableData setValue:[[NSMutableArray alloc] init] forKey:key];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.drinkTypeBar setSelectedItem:self.drinkTypeBar.items[0]];
    [self makeBeverageSearch];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    uint selectedTab = [tabBar.items indexOfObject:item];
    self.selectedIdentifier = self.barTableIdentifiers[selectedTab];
    [self.barItemsTableView reloadData];
    [self makeBeverageSearch];
}

- (void)makeBeverageSearch
{
    HSBeverageAPI *beverageSearch = [[HSBeverageAPI alloc] initWithDelegate:self];
    beverageSearch.successCallback = @selector(searchSuccess:);
    beverageSearch.failureCallback = @selector(searchFailure:);
    [beverageSearch searchForBeveragesWithParameters:@{ @"drink_type" : self.selectedIdentifier, @"rows" : @"1000" }];
}

- (void)searchSuccess:(HSBeverageAPI*)request
{
    [self.barTableData setValue:request[request.apiResultCollectionIdentifier] forKey:self.selectedIdentifier];
    [self.barItemsTableView reloadData];
}

- (void)searchFailure:(HSBeverageAPI*)request
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[HSBarItemDetailsVC class]]){
        NSArray *data = self.barTableData[self.selectedIdentifier];
        HSBarItemDetailsVC *details = segue.destinationViewController;
        details.beverageData = data[self.barItemsTableView.indexPathForSelectedRow.row];
    }
}

/********
 UITableView Data Source/Delegate
 ********/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *data = self.barTableData[self.selectedIdentifier];
    
    HSBarItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"barItemCell"];
    if (cell == nil)
    {
        cell = [[HSBarItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"barItemCell"];
    }
    [cell setupView];
    [cell applyData:data[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *data = self.barTableData[self.selectedIdentifier];
    return data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
