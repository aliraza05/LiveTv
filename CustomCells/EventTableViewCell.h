//
//  EventTableViewCell.h
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *status_lbl;
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;

-(void)loadEvent:(Event *)event;

@end
