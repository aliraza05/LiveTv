//
//  ChannelsTableViewCell.h
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface CategoriesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;

-(void)loadChannel:(Event *)event;

@end
