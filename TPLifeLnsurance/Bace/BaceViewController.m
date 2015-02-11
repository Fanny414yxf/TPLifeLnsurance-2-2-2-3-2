//
//  BaceViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "BaceViewController.h"
#import "ModificationInformationViewController.h"
#import "ModifcationPassWordViewController.h"
#import "AgentViewController.h"

@interface BaceViewController ()

@end

@implementation BaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 365, 667-50);
    self.view.clipsToBounds = YES;
    [self initalizeUserInterface];

}

- (void)initalizeUserInterface
{
    
    _navc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _navc.backgroundColor = COLOR(33, 63, 123, 1);
    _navc.userInteractionEnabled = YES;
    [self.view addSubview:_navc];
    
    
    _personalCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    [_personalCenterButton setImage:[UIImage imageNamed:@"个人中心.png"] forState:UIControlStateNormal];
    [_personalCenterButton addTarget:self action:@selector(processPersonalButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navc addSubview:_personalCenterButton];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH + 30, SCREEN_HEIGHT - 64 - TAB_BAR_HEIGHT)];
    _contentView.backgroundColor = [UIColor yellowColor];
    _contentView.clipsToBounds = YES;
    [self.view addSubview:_contentView];
    
    
}

- (void)processPersonalButton:(UIButton *)sender
{
    
    sender.selected = !sender.selected;

    if ([LoginInforCenter shearLoginInformation].isLogin) {
        
         [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_LOGIN_INFOR object:nil];
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView .frame = CGRectMake(0 ? SCREEN_WIDTH - PERSONAL_WIDTH : 0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -TAB_BAR_HEIGHT);

        }];

    }else{
        
        LoginViewController * loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }
    
        
    
}

- (void)processModifyPersonInformationButton:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_HIDDEN object:self];
    ModificationInformationViewController * modificationInformationVC = [[ModificationInformationViewController alloc] init];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:modificationInformationVC animated:YES];
}

- (void)ModifyPassWordButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_HIDDEN object:self];
    ModifcationPassWordViewController * passWoreVC = [[ModifcationPassWordViewController alloc] init];
    [self.navigationController pushViewController:passWoreVC animated:YES];
}

- (void)processAgantButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_HIDDEN object:self];
    AgentViewController * agentVC = [[AgentViewController alloc] init];
    [self.navigationController pushViewController:agentVC animated:YES];
}


- (void)processExitLoginButton
{
    
    [NetWork sendExitRuquestWithUserId:[ModelData shearInstance].userId CallBack:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"status"] intValue] == 200) {
            
            [LoginInforCenter shearLoginInformation].isLogin = NO;
            NSLog(@"退出成功 ---- %@",result);
            
            
        }
    }];
    
    
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
