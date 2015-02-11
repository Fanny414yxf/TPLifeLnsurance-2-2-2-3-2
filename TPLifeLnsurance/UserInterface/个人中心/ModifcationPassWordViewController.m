//
//  ModifcationPassWordViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-3.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "ModifcationPassWordViewController.h"

@interface ModifcationPassWordViewController ()

@end

@implementation ModifcationPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)initUserInterface
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
    [comeBackButton addTarget:self action:@selector(passwordComeBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [navc addSubview:comeBackButton];
    
    
    
    NSArray * logImage = @[@"修改密码_绿色.png",@"修改密码_绿色.png",@"重置密码.png"];
    NSArray * placeText = @[@"请输入当前登录密码",@"请输入新密码",@"再次输入新密码"];
    
    for (int i = 0; i < 3; i ++) {
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 40, 40)];
        image.image = IMAGE_WITH_NAME(logImage[i]);
        
        UITextField * passWordTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        passWordTF.placeholder = placeText[i];
        passWordTF.layer.borderWidth = 1;
        passWordTF.layer.cornerRadius = 5;
        passWordTF.layer.borderColor = [[UIColor grayColor]CGColor];;
        passWordTF.tag = 300 + i;
        
        if (i == 0) {
            passWordTF.center = CGPointMake(CGRectGetMidX(self.view.bounds), 130);
            image.center = CGPointMake(30, 130);
            
        }else if (i == 1){
            passWordTF.center = CGPointMake(CGRectGetMidX(self.view.bounds), 210);
            image.center = CGPointMake(30, 210);
        }else{
            passWordTF.center = CGPointMake(CGRectGetMidX(self.view.bounds), 270);
            image.center = CGPointMake(30, 270);
            
        }
        [self.view addSubview:passWordTF];
        [self.view addSubview:image];
        
    }
  
    UILabel * labelTip = [[UILabel alloc] initWithFrame:CGRectMake(30, 300, 300, 100)];
    labelTip.textColor = [UIColor orangeColor];
    labelTip.numberOfLines = 5;
    labelTip.text = @"\t\t\t温馨提示:\n密码长度6-18位，必须包含数字和字母\n\t\t请注意区分大小写";
    [self.view addSubview:labelTip];
    
    UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 100, 300, 50)];
    [submitButton setTitle:@"提交修改" forState:UIControlStateNormal];
    submitButton.backgroundColor = COLOR(23, 63, 123, 1);
    submitButton.layer.cornerRadius = 5;
    [submitButton addTarget:self action:@selector(prcessSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

- (void)passwordComeBackButton:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_SHOW object:self];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)prcessSubmitButton:(UIButton *)sender;
{
    NSLog(@"%@",((UITextField *)[self.view viewWithTag:301]).text);
    [NetWork sendRequewrtForEditAppUserWithUserid:[ModelData shearInstance].userId token:[ModelData shearInstance].token passWord:((UITextField *)[self.view viewWithTag:301]).text callback:^(id result) {
        if ([result[@"dara"][@"dtutas"] integerValue] == 200) {
            NSLog(@"修改成功");
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
