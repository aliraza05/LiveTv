//
//  CustomWindow.m
//  PicSpot
//
//  Created by Ibrar Ahmed on 28/09/2016.
//  Copyright © 2016 SDSol Technologies. All rights reserved.
//

#import "CustomWindow.h"

@implementation CustomWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)showHUDWithText:(NSString*)text
{
    [self removeHUD];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.removeFromSuperViewOnHide = YES;
    [self addSubview:hud];
    hud.label.text = text;
    [hud showAnimated:YES];
}

-(void)removeHUD
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

-(void)showProgressHUD
{
    [self removeHUD];
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.mode = MBProgressHUDModeCustomView;
    self.mbroundProgress = [[MBRoundProgressView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    
    HUD.customView = self.mbroundProgress;

    self.mbroundProgress.progress = 0.0;
    self.mbroundProgress.annular = YES;
    self.mbroundProgress.progressTintColor = [UIColor customBlueThemColor];
    self.mbroundProgress.backgroundTintColor = [UIColor redColor];
    
    
    HUD.detailsLabel.text = NSLocalizedString(@"Uploading...", nil) ;
    [self addSubview:HUD];
    [HUD showAnimated:YES];
    
        });
}

@end
