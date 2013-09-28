//
//  HSBarItemCell.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarItemCell.h"

@interface HSBarItemCell ()
@property (strong) IBOutlet UILabel     *menuItemNameLabel;
@property (strong) IBOutlet UILabel     *menuItemTypeLabel;
@property (strong) IBOutlet UILabel     *likedLabel;
@end

@implementation HSBarItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupView
{
    
}

@end
