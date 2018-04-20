//
//  FirstViewController.m
//  livestreaming
//
//  Created by Ali Raza on 20/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<BusinessLayerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[BusinessLayer sharedLayer] fetchAppDataWithDelegate:self showHUD:YES ];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BusinessLayerDelegate
-(void)didReceiveResponseOfApi:(ApiName)api OnSuccess:(NSMutableArray*)dataArray
{
    if (dataArray.count > 1 && api == eApiFetchAppData)
    {
        //
        
    }
}
-(void)didReceiveResponseOfApi:(ApiName)api OnFailure:(NSError*)error
{
    [self.view makeToast:error.localizedDescription duration:kToastViewDuration position:@"center"];
}


@end
