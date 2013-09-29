//
//  HSBarMenuVC.h
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBaseVC.h"

@interface HSBarMenuVC : HSBaseVC <UITableViewDelegate, UITableViewDataSource, UITabBarDelegate>
@property (strong) HSBar *barData;
@end
