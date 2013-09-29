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
    self.barTableIdentifiers = @[@"",@"",@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.drinkTypeBar setSelectedItem:self.drinkTypeBar.items[0]];
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
}

/********
 UITableView Data Source/Delegate
 ********/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSBarItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"barItemCell"];
    if (cell == nil)
    {
        cell = [[HSBarItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"barItemCell"];
    }
    [cell setupView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
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
