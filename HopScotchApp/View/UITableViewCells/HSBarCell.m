//
//  HSBarCell.m
//  HopScotch
//
//  Created by Maxwell Cabral on 9/28/13.
//  Copyright (c) 2013 HopScotch. All rights reserved.
//

#import "HSBarCell.h"

@interface HSBarCell ()
@property (strong)  IBOutlet UILabel        *barNameLabel;
@property (strong)  IBOutlet UILabel        *barInfo1Label;
@property (strong)  IBOutlet UILabel        *barInfo2Label;
@end

@implementation HSBarCell

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

- (void)applyData:(HSBar*)data
{
    self.barNameLabel.text = data.name;
}

@end
