//
//  SplashViewController.m
//  livestreaming
//
//  Created by Ali Raza on 24/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@property (weak, nonatomic) IBOutlet UILabel *heading_lbl;
@property (weak, nonatomic) IBOutlet UILabel *description_lbl;
@property (weak, nonatomic) IBOutlet UIButton *download_btn;
- (IBAction)downloadAction:(id)sender;
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float splashTime = 5.0;
    
    for (NSDictionary *dict in _configuration)
    {
        NSString *key = [dict objectForKey:@"key"];
        
        if ([key isEqualToString:@"Heading"])
        {
            _heading_lbl.text = [dict valueForKey:@"value"];
        }
        if ([key isEqualToString:@"DetailText"])
        {
            _description_lbl.text = [dict valueForKey:@"value"];
        }
        if ([key isEqualToString:@"ButtonText"])
        {
            NSString *title = [NSString stringWithFormat:@"   %@   ",[dict valueForKey:@"value"]];
            [_download_btn setTitle:title forState:UIControlStateNormal];
        }
        if ([key isEqualToString:@"ShowButton"])
        {
            BOOL showBtn = [[dict valueForKey:@"value"] boolValue];
            [_download_btn setHidden:!showBtn];
        }
        if ([key isEqualToString:@"Time"])
        {
            splashTime = [[dict valueForKey:@"value"] floatValue];
        }
    }
    
//    [self performSelector:@selector(hideSplash) withObject:nil afterDelay:splashTime];
    
    [self performSelector:@selector(hideSplash) withObject:nil afterDelay:1.0];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideSplash
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)downloadAction:(id)sender
{
    
}
@end
