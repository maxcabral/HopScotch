//
//  HSBaseCell.h
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSBaseCell : UITableViewCell
@property (weak) id<UITableViewDelegate,UITableViewDataSource> tableViewController;
- (void)setupView;
- (void)applyData:(id)data;
@end
