//
//  OIImageCell.m
//  OrganizeIt
//
//  Created by lk1195 on 10/20/14.
//  Copyright (c) 2014 lk1195. All rights reserved.
//

#import "OIImageCell.h"

@implementation OIImageCell

@synthesize noteImageView = _noteImageView;

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

@end
