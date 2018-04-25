//
//  CustomWindow.h
//  PicSpot
//
//  Created by Ibrar Ahmed on 28/09/2016.
//  Copyright © 2016 SDSol Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface CustomWindow : UIWindow

@property (nonatomic, strong) MBRoundProgressView *mbroundProgress;
-(void)showProgressHUD;

- (void)showHUDWithText:(NSString*)text;
- (void)removeHUD;

-(void)showsplashWithConfiguration:(NSArray *)configuration;

@end
