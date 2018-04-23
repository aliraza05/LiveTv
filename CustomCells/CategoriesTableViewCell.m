//
//  ChannelsTableViewCell.m
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "CategoriesTableViewCell.h"

@implementation CategoriesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _catImageView.layer.cornerRadius = 15;
    _catImageView.layer.masksToBounds = true;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadChannel:(Event *)event
{
    self.name_lbl.text = event.name;
}
@end
