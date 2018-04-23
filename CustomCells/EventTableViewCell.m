//
//  EventTableViewCell.m
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _containerView.layer.cornerRadius = 15;
    _containerView.layer.masksToBounds = true;
    
    
    _iconView.layer.cornerRadius = 20;
    _iconView.layer.masksToBounds = true;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadEvent:(Event *)event
{
    self.name_lbl.text = event.name;
    
    if (event.live)
    {
        [self.status_lbl setHidden:NO];
    }else
    {
        [self.status_lbl setHidden:YES];
    }
}
@end
