//
//  ChannelTableViewCell.h
//  livestreaming
//
//  Created by Ali Raza on 25/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

@interface ChannelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *channel_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;

-(void)loadChannel:(Channel *)chanl;

@end
