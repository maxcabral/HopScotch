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
@property (strong) IBOutlet UILabel             *barNameDescriptionLabel;
@property (strong) IBOutlet UILabel             *barHappyHourLabel;
@property (strong) IBOutlet UILabel             *barHappyHourDescriptionLabel;
@property (strong) IBOutlet UILabel             *barHoursLabel;
@property (strong) IBOutlet UILabel             *barHoursDescriptionLabel;
@property (strong) IBOutlet UISegmentedControl  *viewOptionsSegmentedControl;
@property (strong) IBOutlet UITableView         *barDataTableView;
@property (strong)          NSMutableDictionary *barTableData;
@end

@implementation HSBarVC
@synthesize barImage;
@synthesize barNameLable;
@synthesize barNameDescriptionLabel;
@synthesize barHappyHourLabel;
@synthesize barHappyHourDescriptionLabel;
@synthesize barHoursLabel;
@synthesize barHoursDescriptionLabel;
@synthesize viewOptionsSegmentedControl;
@synthesize barDataTableView;
@synthesize barTableData;
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

- (IBAction)viewOptionsValueChanged:(UISegmentedControl *)sender {

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
    return 60.0;
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
