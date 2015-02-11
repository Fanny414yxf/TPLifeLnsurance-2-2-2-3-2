//
//  LoginViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-2.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface LoginViewController ()
{
    
}

@property (nonatomic,strong)UIButton * comebackMainButton;
@property (nonatomic,strong)UIButton * loginButton;
@property (nonatomic,strong)UIButton * registrationButton;
@property (nonatomic,strong)UIButton * findPassWordButton;

@property (nonatomic,strong)UITextField * userNameTF;
@property (nonatomic,strong)UITextField * passWordTF;
//@property (nonatomic,strong)ModelData * obj;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(33, 63, 123, 1);
    [self initalizedeUserInterface];
//    _obj = [[ModelData alloc] init];

}


- (void)initalizedeUserInterface
{
    
    _comebackMainButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 70, 30, 30)];
    [_comebackMainButton setImage:[UIImage imageNamed:@"bu_closs@2x.png"] forState:UIControlStateNormal];
    [_comebackMainButton addTarget:self action:@selector(processComeBackMainBUtton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_comebackMainButton];
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50,150 ,220, 80)];
    imageView.image = IMAGE_WITH_NAME(@"logo@2x.png");
    [self.view addSubview:imageView];
    
    
    UIImageView * userLog = [[UIImageView alloc] initWithFrame:CGRectMake(20, 280, 40, 40)];
    userLog.image = IMAGE_WITH_NAME(@"帐号.png");
    [self.view addSubview:userLog];
    
    UIImageView * passWordLog = [[UIImageView alloc] initWithFrame:CGRectMake(20, 340, 40, 40)];
    passWordLog.image = IMAGE_WITH_NAME(@"密码.png");
    [self.view addSubview:passWordLog];
    
    
    UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 325, 350, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(140, 280, 120, 40)];
    _userNameTF.placeholder = @"请输入用户名";
    _userNameTF.textColor = [UIColor whiteColor];
    _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_userNameTF];
    
    _passWordTF = [[UITextField alloc] initWithFrame:CGRectMake(140, 340, 120, 40)];
    _passWordTF.textColor = [UIColor whiteColor];
    _passWordTF.placeholder = @"请输入密码";
    _passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_passWordTF];
    
    
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 280, 60)];
    [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = FONT(25);
    _loginButton.backgroundColor = COLOR(95, 130, 197, 1);
    _loginButton.layer.cornerRadius = 10;
    [_loginButton addTarget:self action:@selector(processLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _registrationButton = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetHeight(self.view.bounds)-100, 120, 40)];
    [_registrationButton setTitle:@"注册新用户" forState:UIControlStateNormal];
    [_registrationButton addTarget:self action:@selector(processRegistionButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registrationButton];
    
    _findPassWordButton = [[UIButton alloc]initWithFrame:CGRectMake(240, CGRectGetHeight(self.view.bounds)-100, 80, 40)];
    [_findPassWordButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.view addSubview:_findPassWordButton];
    
    
    
    
}


- (void)processComeBackMainBUtton
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)processLoginButton
{
    [NetWork sendLoginRequestWithUserName:@"user01" passWord:@"123abc" callback:^(id result) {
        if ([result[@"status"] integerValue] == 200) {
            [ModelData shearInstance].userId = result[@"data"][@"userId"];
            [ModelData shearInstance].userName = result[@"data"][@"userName"];
            [ModelData shearInstance].token = result[@"data"][@"token"];
    
            [LoginInforCenter shearLoginInformation].isLogin = YES;
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
             NSLog(@"登录成功%@",result[@"status"]);
    
            
            [NetWork sendRequesrToGetAppUserInfoWithUserid:[ModelData shearInstance].userId token:[ModelData shearInstance].token callback:^(id result) {
                {
                    NSLog(@"个人信息%@",result);
                    
                    [ModelData shearInstance].agentList = result[@"data"][@"agentList"];
                    [ModelData shearInstance].uid = result[@"data"][@"id"];
                    [ModelData shearInstance].login_name = result[@"data"][@"login_name"];
                    [ModelData shearInstance].name = result[@"data"][@"name"];
                    [ModelData shearInstance].telephone = result[@"data"][@"telephone"];
                    [ModelData shearInstance].id_card = result[@"data"][@"id_card"];
                    
                }
            }];
        }
    }];
}

- (void)processRegistionButton
{
    
    RegistrationViewController * registrationVC = [[RegistrationViewController alloc] init];
    [registrationVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:registrationVC animated:YES completion:nil];
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
