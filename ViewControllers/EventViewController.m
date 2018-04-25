//
//  FirstViewController.m
//  livestreaming
//
//  Created by Ali Raza on 20/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "EventViewController.h"
#import "EventTableViewCell.h"
#import "Event.h"
#import "Channel.h"
#import "ChannelsViewController.h"

@interface EventViewController ()<BusinessLayerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *tableDataArray;

    BOOL isFirstTime;
}
@property (weak, nonatomic) IBOutlet UITableView *eventTableView;
@property (weak, nonatomic) IBOutlet UILabel *dateTime_lbl;
@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"EventTableViewCell" bundle:nil];
    [self.eventTableView registerNib:cellNib forCellReuseIdentifier:@"EventTableViewCell"];
    
    isFirstTime = YES;
    tableDataArray =[[NSMutableArray alloc]init];
    
    NSDateFormatter *utcFormatter = [[NSDateFormatter alloc] init];
    [utcFormatter setDateFormat:@"d MMM, EEEE"];
    NSString *datetime = [utcFormatter stringFromDate:[NSDate date]];
    
    [_dateTime_lbl setText:datetime];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BusinessLayer sharedLayer] fetchAppDataWithDelegate:self showHUD:YES ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BusinessLayerDelegate
-(void)didReceiveResponseOfApi:(ApiName)api OnSuccess:(NSMutableArray*)dataArray
{
    if (dataArray.count > 0 && api == eApiFetchAppData)
    {
        //
        [tableDataArray removeAllObjects];
        NSDictionary *data = [dataArray firstObject];
        
        if (isFirstTime)
        {
            NSArray *configurationAry = [data valueForKey:@"application_configurations"];
            
            for (NSDictionary *dict in configurationAry)
            {
                NSString *key = [dict objectForKey:@"key"];
                
                if ([key isEqualToString:@"ShowSplash"])
                {
                    BOOL showSplash = [[dict valueForKey:@"value"] boolValue];
                    if (showSplash)
                    {
                        
                        [APP_DELEGATE.window showsplashWithConfiguration:[data valueForKey:@"application_configurations"]];
                        isFirstTime = NO;
                    }
                }
            }
        }
        
        NSArray *events = [data objectForKey:@"events"];
        
        for (NSDictionary *dict in events)
        {
            Event *e = [[Event alloc]initWithDictionary:dict];
            [tableDataArray addObject:e];
        }
        
        [_eventTableView reloadData];
        
        
    }
}
-(void)didReceiveResponseOfApi:(ApiName)api OnFailure:(NSError*)error
{
    [self.view makeToast:error.localizedDescription duration:kToastViewDuration position:@"center"];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Event *evnt = [tableDataArray objectAtIndex:indexPath.row];
    [cell loadEvent:evnt];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *evnt = [tableDataArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showCategoryChannels" sender:evnt];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showCategoryChannels"])
    {
        ChannelsViewController *vc = (ChannelsViewController *) [segue destinationViewController];
        vc.event = (Event *)sender;
    }
}
@end
