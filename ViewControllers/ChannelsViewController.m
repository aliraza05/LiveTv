//
//  ChannelsViewController.m
//  livestreaming
//
//  Created by Ali Raza on 25/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "ChannelsViewController.h"
#import "ChannelTableViewCell.h"

@interface ChannelsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *tableDataArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *channelTableView;
@property (weak, nonatomic) IBOutlet UILabel *channelName;

@end

@implementation ChannelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"ChannelTableViewCell" bundle:nil];
    [self.channelTableView registerNib:cellNib forCellReuseIdentifier:@"ChannelTableViewCell"];
    
    if (_event.channels)
    {
        tableDataArray =[[NSMutableArray alloc]initWithArray:_event.channels];
    }else
    {
        tableDataArray =[[NSMutableArray alloc]init];
    }
    
    _channelName.text = _event.name;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelTableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Channel *chanl = [tableDataArray objectAtIndex:indexPath.row];
    [cell loadChannel:chanl];
    
    return cell;
}


@end
