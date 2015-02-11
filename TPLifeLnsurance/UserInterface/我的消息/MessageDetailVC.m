//
//  MessageDetailVC.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-7.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MessageDetailVC.h"
#import "MessageDetailTableViewCell.h"

@interface MessageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger cell_hight;
}

@property (nonatomic,strong)NSMutableDictionary * dataSource;

@property (nonatomic,strong)UITableView * messageList;
@property (nonatomic,strong)UIView * footView;
@property (nonatomic,strong)UITextField * sendMessageTextField;
@property (nonatomic,strong)UIButton * sendButton;

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self.backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(processBackButton) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.text = self.receiverName;
    [self refreshMessageDetailWithRequest];
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    
    _dataSource = [[NSMutableDictionary alloc] init];
    
    _messageList = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVC_HIGTH, SCREEN_WIDTH, SCREEN_HEIGHT - NAVC_HIGTH - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _messageList.delegate = self;
    _messageList.dataSource = self;
    _messageList.separatorColor = [UIColor clearColor];
    [_messageList registerClass:[MessageDetailTableViewCell class] forCellReuseIdentifier:@"messageDatailCell"];
    [self.view addSubview:_messageList];
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - NAVC_HIGTH - 50, SCREEN_WIDTH, 60)];
    _footView.backgroundColor = COLOR(236, 236, 236, 1);
    _footView.layer.borderColor = [[UIColor blackColor]CGColor];;
    _footView.layer.borderWidth = 1;
//    _footView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_footView];
    
    _sendMessageTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 260, 30)];
    
    _sendMessageTextField.layer.borderWidth = 1;
    _sendMessageTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    _sendMessageTextField.layer.cornerRadius = 5;
    [_footView addSubview:_sendMessageTextField];
    
    
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 80, 30)];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal
     ];
    [_sendButton addTarget:self action:@selector(processSendButton) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_sendButton];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[@"msgList"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"messageDatailCell"];
    NSString * string = _dataSource[@"msgList"][indexPath.row][@"content"];
    UIFont * font = [UIFont systemFontOfSize:18];
    CGSize contentSize = CGSizeMake(280, 1000);
    
  CGRect autoRect = [string boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    cell_hight = autoRect.size.height + 50;
    if ([_dataSource[@"displayName"] isEqualToString:@"System"]) {
        [cell  setCellSystemMessageDetailContentWithInfo:_dataSource[@"msgList"][indexPath.row] size_x:autoRect.size.width size_h:autoRect.size.height];
        return cell;
    }else{
    [cell sendMessageDetailContentWinthInfo:_dataSource[@"msgList"][indexPath.row] size_x:autoRect.size.width size_h:autoRect.size.height];

    return cell;
}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return cell_hight + 40;
    
}

- (void) processBackButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_SHOW object:self];

}

- (void)refreshMessageDetailWithRequest
{
    [NetWork sendGetMessageListRequestByUserdi:[ModelData shearInstance].userId messageid:[NSString stringWithFormat:@"%@",self.messageId] token:[ModelData shearInstance].token callback:^(id result) {
        NSLog(@"消息详情页%@",result);
        _dataSource = result[@"data"];
        [_messageList reloadData];
    }];
}



- (void)processSendButton
{
    if ([_dataSource[@"displayName"] isEqualToString:@"System"])
    {
        UIAlertView * alertc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不能给系统发送站内信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertc show];
        
    }
    else
    {
        [NetWork senderSendMessageNetWorkingWithUserid:[ModelData shearInstance].userId receiveId:_dataSource[@"msgList"][0][@"receiverId"] content:_sendMessageTextField.text token:[ModelData shearInstance].token callback:^(id result) {
            
            NSLog(@"%@",result);
            if ([result[@"status"] intValue] == 200 )
            {
                NSLog(@"发送成功");
                [_messageList reloadData];
            }
        }];
    }

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
