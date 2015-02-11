//
//  ModificationInformationViewController.m
//  TPLifeLnsurance
//
//  Created by Magic Johnson on 2/2/15.
//  Copyright (c) 2015 Yangxiaofen. All rights reserved.
//

#import "ModificationInformationViewController.h"
#import "MessageDetailVC.h"

@interface ModificationInformationViewController ()
//@property (nonatomic,strong)UITextField
@end

@implementation ModificationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)initUserInterface
{
//    self.navigationController.navigationBarHidden = NO;
//    self.navigationItem.title = @"修改个人资料";
//    self.navigationController.navigationBar.backgroundColor = COLOR(33, 63, 123, 1);

    UIImageView * navc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navc.userInteractionEnabled = YES;
    navc.backgroundColor = COLOR(33, 63, 123, 1);
    [self.view addSubview:navc];
    [self.navigationController setTitle:@"修改个人资料"];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    titleLabel.text = @"修改个人资料";
    titleLabel.textColor = [UIColor whiteColor];
    [navc addSubview:titleLabel];
     UIButton * comeBackButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [comeBackButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [comeBackButton addTarget:self action:@selector(ComeBackButton) forControlEvents:UIControlEventTouchUpInside];
    [navc addSubview:comeBackButton];
    
    
    NSArray * labelArray = @[@"账号:",@"姓名:",@"证件号:",@"手机号:",@"代理人个人代码:",@"代理人:"];
    for (int i = 0; i < 6; i ++) {
        
        UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake(50, 80 + i * 40, 250, 30)];
        label.text = labelArray[i];
        label.font  = FONT(15);
        label.textColor = [UIColor grayColor];
        [self.view addSubview:label];
        
        
        UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
        detailLabel.tag = i + 200;
        detailLabel.textColor = [UIColor blackColor];
        [self.view addSubview:detailLabel];
        if (i == 0) {
            detailLabel.center = CGPointMake(220, 95);
            detailLabel.text = [ModelData shearInstance].login_name;
        }else if (i == 1){
            detailLabel.center = CGPointMake(220, 135);
            detailLabel.text = [ModelData shearInstance].name;
        }else if (i == 2){
            detailLabel.center = CGPointMake(250, 175);
            detailLabel.text = [ModelData shearInstance].id_card;
        }else if (i == 3){
            [detailLabel removeFromSuperview];
            UITextField * IDNumber = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 30)];
            IDNumber.tag = 222;
            IDNumber.layer.borderColor = [[UIColor grayColor]CGColor];
            IDNumber.layer.borderWidth = 1;
            IDNumber.layer.cornerRadius = 5;
            IDNumber.text = [ModelData shearInstance].telephone;
            [self.view addSubview:IDNumber];
        }else if (i == 4){
            detailLabel.center = CGPointMake(300, 255);
            detailLabel.text = [ModelData shearInstance].agentList[0][@"agent_personalCode"];
        }else if (i == 5){
            detailLabel.center = CGPointMake(240, 295);
            detailLabel.text = [ModelData shearInstance].agentList[0][@"agent_name"];
        }
        
    }
    
    UIButton * sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 280, 120, 30)];
    sendMessageButton.layer.borderColor = [[UIColor blueColor]CGColor];;
    sendMessageButton.layer.borderWidth = 1;
    sendMessageButton.layer.cornerRadius = 5;
    [sendMessageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sendMessageButton setTitle:@"发送消息" forState:UIControlStateNormal];
    [sendMessageButton addTarget:self action:@selector(processSendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageButton];
    
    
    UIButton * shureButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 560, 340, 40)];
    shureButton.layer.borderColor = [[UIColor blueColor]CGColor];;
    shureButton.layer.borderWidth = 1;
    shureButton.layer.cornerRadius = 10;
    [shureButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [shureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shureButton addTarget:self action:@selector(processShureButton:) forControlEvents:UIControlEventTouchUpInside];
    shureButton.backgroundColor = COLOR(23, 63, 123, 1);
    [self.view addSubview:shureButton];
    
    
    

    
}







- (void)ComeBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_SHOW object:self];
}

- (void)processShureButton:(UIButton *)sender
{
    if ([[ModelData shearInstance].telephone isEqualToString:((UITextField *)[self.view viewWithTag:222]).text ]) {
        NSLog(@"无任何修改");
    }else{
    [NetWork sendRequewrtForEditAppUserWithUserid:[ModelData shearInstance].userId token:[ModelData shearInstance].token telephone:((UITextField *)[self.view viewWithTag:222]).text callback:^(id result) {
        NSLog(@"确认修改%@",result);
    }];
    }
}


- (void)processSendMessage
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
