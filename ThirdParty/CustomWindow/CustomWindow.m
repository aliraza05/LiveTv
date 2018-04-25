//
//  CustomWindow.m
//  PicSpot
//
//  Created by Ibrar Ahmed on 28/09/2016.
//  Copyright © 2016 SDSol Technologies. All rights reserved.
//

#import "CustomWindow.h"
#import "SplashViewController.h"

@implementation CustomWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)showsplashWithConfiguration:(NSArray *)configuration
{
//    [self.navigationController.navigationBar.layer setZPosition:-0.1];
    
    SplashViewController *webView = [[SplashViewController alloc]initWithNibName:@"SplashViewController" bundle:nil];
    
    
    webView.configuration = configuration;
    
    webView.view.frame = APP_DELEGATE.window.frame;
    
    [APP_DELEGATE.window.rootViewController addChildViewController:webView];
    
    [APP_DELEGATE.window.rootViewController.view addSubview:webView.view];
    [APP_DELEGATE.window.rootViewController.view bringSubviewToFront:webView.view];
    APP_DELEGATE.window.rootViewController.view.clipsToBounds = NO;
    
    [webView didMoveToParentViewController:APP_DELEGATE.window.rootViewController];
}

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
