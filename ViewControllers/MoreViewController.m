//
//  MoreViewController.m
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

- (IBAction)termsAction:(id)sender;
- (IBAction)mailAction:(id)sender;
- (IBAction)rateUsAction:(id)sender;
- (IBAction)versionAction:(id)sender;
- (IBAction)supportAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *version_btn;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

    [self.version_btn setTitle:[NSString stringWithFormat:@"Version %@",appVersionString] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)termsAction:(id)sender {
}

- (IBAction)mailAction:(id)sender {
}

- (IBAction)rateUsAction:(id)sender {
}

- (IBAction)versionAction:(id)sender {
}

- (IBAction)supportAction:(id)sender {
}
@end
