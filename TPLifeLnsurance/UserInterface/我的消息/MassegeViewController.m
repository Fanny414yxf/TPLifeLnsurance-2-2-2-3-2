//
//  MassegeViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MassegeViewController.h"
#import "MessageCellTableViewCell.h"
#import "MessageDetailVC.h"
@interface MassegeViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong)

@property (nonatomic,strong)UITableView * messageTabelView;
@property (nonatomic,strong)NSMutableArray * dataSource;


@end

@implementation MassegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    [self refreshWithRequest];
    [self userInterface];
    _dataSource = [[NSMutableArray alloc] init];
}

- (void)userInterface
{
    
    
    
    
    UIButton * newMassegeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 30, 30, 30)];
    [newMassegeButton setImage:[UIImage imageNamed:@"新建消息.png"] forState:UIControlStateNormal];
    [newMassegeButton addTarget:self action:@selector(processNewMessageButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navc addSubview:newMassegeButton];
    
    UILabel * titlieLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 50, 25)];
    titlieLabel.text = @"消息";
    titlieLabel.textColor = [UIColor whiteColor];
    titlieLabel.font = FONT(24);
    [self.navc addSubview:titlieLabel];
    
    
    
    _messageTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVC_HIGTH, SCREEN_WIDTH, SCREEN_HEIGHT - NAVC_HIGTH - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _messageTabelView.delegate = self;
    _messageTabelView.dataSource = self;
    [_messageTabelView registerClass:[MessageCellTableViewCell class] forCellReuseIdentifier:@"massageCell"];
    [self.view addSubview:_messageTabelView];

}

#pragma maerk - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"massageCell"];
    [cell setCellContentWithInfo:_dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailVC * messageDetailVC = [[MessageDetailVC alloc] init];
    messageDetailVC.messageId = _dataSource[indexPath.row][@"messageId"];
    messageDetailVC.receiverName = _dataSource[indexPath.row][@"receiverName"];
    [self.navigationController pushViewController:messageDetailVC animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_HIDDEN object:self];

}



- (void)refreshWithRequest
{
    [NetWork sendGetMessageListRequestByUserid:[ModelData shearInstance].userId currentPage:1 pageSize:3 token:[ModelData shearInstance].token callback:^(id result) {
        NSLog(@"消息列表%@",result);
        _dataSource = result[@"data"][@"msgList"];
        [_messageTabelView reloadData];
        
        
    }];
}





- (void)processNewMessageButton
{
    
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

@end
