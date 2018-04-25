//
//  ChannelTableViewCell.m
//  livestreaming
//
//  Created by Ali Raza on 25/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "ChannelTableViewCell.h"

@implementation ChannelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _channel_img.layer.cornerRadius = 15;
    _channel_img.layer.masksToBounds = true;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadChannel:(Channel *)chanl
{
    _name_lbl.text = chanl.name;
}

@end
