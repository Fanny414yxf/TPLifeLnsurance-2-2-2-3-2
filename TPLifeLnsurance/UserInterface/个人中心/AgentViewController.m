//
//  AgentViewController.m
//  TPLifeLnsurance
//
//  Created by Magic Johnson on 2/2/15.
//  Copyright (c) 2015 Yangxiaofen. All rights reserved.
//

#import "AgentViewController.h"

@interface AgentViewController ()

@end

@implementation AgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUserINterface];
    self.view.backgroundColor = [UIColor whiteColor];

}


- (void)initUserINterface
{
    
    UIImageView * navc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navc.userInteractionEnabled = YES;
    navc.backgroundColor = COLOR(33, 63, 123, 1);
    [self.view addSubview:navc];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    titleLabel.text = @"代理人信息";
    titleLabel.textColor = [UIColor whiteColor];
    [navc addSubview:titleLabel];
    UIButton * comeBackButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [comeBackButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [comeBackButton addTarget:self action:@selector(agentComeBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [navc addSubview:comeBackButton];
    NSArray * labelArray = @[@"代理人个人代码：",@"姓名：",@"手机号："];
    for (int i = 0; i < 3; i ++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100 + i * 30, 250, 30)];
        label.textColor = [UIColor grayColor];
        label.font = FONT(15);
        label.text = labelArray[i];
        [self.view addSubview:label];
        
        UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        detailLabel.textColor = [UIColor blackColor];
        [self.view addSubview:detailLabel];
        
        if (i == 0) {
            detailLabel.center = CGPointMake(230, 115);
            detailLabel.text = [ModelData shearInstance].agentList[0][@"agent_personalCode"];
        }else if (i == 1){
            detailLabel.center = CGPointMake(160, 150);
            detailLabel.text = [ModelData shearInstance].agentList[0][@"agent_name"];
        }else{
            detailLabel.center = CGPointMake(160, 180);
            detailLabel.text = [ModelData shearInstance].agentList[0][@"agent_telephone"];

        }
        
        
    }
    UIButton * sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 100, 40)];
    sendMessageButton.layer.borderColor = [[UIColor orangeColor]CGColor];;
    sendMessageButton.layer.borderWidth = 1;
    sendMessageButton.layer.cornerRadius = 5;
    [sendMessageButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [sendMessageButton setTitle:@"发送消息" forState:UIControlStateNormal];
    [sendMessageButton addTarget:self action:@selector(processAngentSendMessage) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sendMessageButton];
    
    UIButton * callButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 200, 50, 40)];
    [callButton setImage:[UIImage imageNamed:@"电话2.png"] forState:UIControlStateNormal];
    [self.view addSubview:callButton];
    UIButton * messageButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 200, 50, 40)];
    [messageButton setImage:[UIImage imageNamed:@"短信2.png"] forState:UIControlStateNormal];
    [self.view addSubview:messageButton];
    
    
    
}


- (void)agentComeBackButton:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_SHOW object:self];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)processAngentSendMessage
{
    UIAlertView * alertc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无可发送消息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertc show];
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
