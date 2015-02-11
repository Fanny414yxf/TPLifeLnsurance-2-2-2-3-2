//
//  ViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "ViewController.h"
#import "TabarView.h"

#import "ShopViewController.h"
#import "MassegeViewController.h"
#import "BookingViewController.h"
#import "ModifcationPassWordViewController.h"
#import "ModificationInformationViewController.h"
#import "AgentViewController.h"


@interface ViewController () <TabBarViewDelegate>
{
    BOOL _isFirstPush;
}


@property (nonatomic,strong)TabarView * tabarView;
@property (nonatomic,strong)UIView * centerView;
@property (nonatomic,strong)UINavigationController * curentNavc;
@property (nonatomic,strong)UIView * leftView;



@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isFirstPush = NO;
    
    
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _centerView.userInteractionEnabled = YES;
    [self.view addSubview:_centerView];
    
    _tabarView = [[TabarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TAB_BAR_HEIGHT, SCREEN_WIDTH, TAB_BAR_HEIGHT)];
    _tabarView.backgroundColor = COLOR(194, 204, 226, 1);
    _tabarView.delegate = self;
    [self.view addSubview:_tabarView];
    
    
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(-PERSONAL_WIDTH, 80, PERSONAL_WIDTH, SCREEN_HEIGHT + 20)];
        _leftView.clipsToBounds = YES;
        _leftView.backgroundColor = [UIColor blueColor];
        _leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mybackground.jpg"]];
        [self.view addSubview:_leftView];
    
        UILabel * labelTip = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 100)];
    labelTip.tag = 10000;
        labelTip.textColor = [UIColor whiteColor];
        labelTip.font = FONT(18);
        labelTip.numberOfLines = 10;
        [_leftView addSubview:labelTip];
        
        NSArray * log = @[@"新建消息.png",@"修改密码.png",@"我的代理人.png"];
        NSArray * title = @[@"修改个人信息",@"修改登录密码",@"我的代理人信息"];
        UIButton * ModifyPersonalInformationButton = [[UIButton alloc] initWithFrame:CGRectMake(-3, 150 + 0 * 58, PERSONAL_WIDTH + 5, 60)];
        ModifyPersonalInformationButton.tag = 101 ;
        ModifyPersonalInformationButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        ModifyPersonalInformationButton.layer.borderWidth = 2;
        [ModifyPersonalInformationButton setTitle:title[0] forState:UIControlStateNormal];
        [ModifyPersonalInformationButton setImage:[UIImage imageNamed:log[0]] forState:UIControlStateNormal];
        ModifyPersonalInformationButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, PERSONAL_WIDTH - 45);
        ModifyPersonalInformationButton.titleLabel.center = CGPointMake(40, CGRectGetMidY(ModifyPersonalInformationButton.bounds));
        [ModifyPersonalInformationButton addTarget:self action:@selector(processModifyPersonInformationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:ModifyPersonalInformationButton];
        
        
        UIButton * ModifyPassWordButton = [[UIButton alloc] initWithFrame:CGRectMake(-3, 150 + 1 * 58, PERSONAL_WIDTH + 5, 60)];
        ModifyPassWordButton.tag = 102;
        ModifyPassWordButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        ModifyPassWordButton.layer.borderWidth = 2;
        [ModifyPassWordButton setTitle:title[1] forState:UIControlStateNormal];
        [ModifyPassWordButton setImage:[UIImage imageNamed:log[1]] forState:UIControlStateNormal];
        ModifyPassWordButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, PERSONAL_WIDTH - 45);
        ModifyPassWordButton.titleLabel.center = CGPointMake(40, CGRectGetMidY(ModifyPassWordButton.bounds));
        [ModifyPassWordButton addTarget:self action:@selector(ModifyPassWordButton) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:ModifyPassWordButton];
        
        UIButton * myAgentButton = [[UIButton alloc] initWithFrame:CGRectMake(-3, 150 + 2 * 58, PERSONAL_WIDTH + 5, 60)];
        myAgentButton.tag = 103;
        myAgentButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        myAgentButton.layer.borderWidth = 2;
        [myAgentButton setTitle:title[2] forState:UIControlStateNormal];
        [myAgentButton setImage:[UIImage imageNamed:log[2]] forState:UIControlStateNormal];
        myAgentButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, PERSONAL_WIDTH - 45);
        myAgentButton.titleLabel.center = CGPointMake(40, CGRectGetMidY(ModifyPersonalInformationButton.bounds));
        [myAgentButton addTarget:self action:@selector(processAgantButton) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:myAgentButton];
        
        
        
        UIButton * exitLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 450, 100, 50)];
        exitLoginButton.layer.borderWidth = 2;
        exitLoginButton.layer.cornerRadius = 6;
        exitLoginButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        [exitLoginButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitLoginButton addTarget:self action:@selector(processExitLoginButton) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:exitLoginButton];
        [self.view addSubview:_leftView];


    

    //发送通知给tabBar 默认选中第0个按钮  @0 对象
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SWITCH_TAB_BAR object:@0];
    

    //tabbar的现实 与隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarHidden) name:NOTIFY_TAB_BAR_HIDDEN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarShow) name:NOTIFY_TAB_BAR_SHOW object:nil];
    //个人中心移动否
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveLeftView:) name:NOTIFY_LOGIN_INFOR object:nil];


}


#pragma mark --- <TabBarViewDelegate>

- (void)tabBarDidSelectedWithIndex:(NSInteger)selectedIndex
{
    if ([LoginInforCenter shearLoginInformation].isLogin) {
        switch (selectedIndex) {
            case 0:{
                ShopViewController * shopVC = [[ShopViewController alloc] init];
                shopVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
                UINavigationController * shopNavc = [[UINavigationController alloc]initWithRootViewController:shopVC];
                shopNavc.navigationBarHidden = YES;
                
            [self pushAnimationWithProcess:shopNavc];


                
            }
                break;
            case 1:
            {
                MassegeViewController * shopVC = [[MassegeViewController alloc] init];
                UINavigationController * shopNavc = [[UINavigationController alloc]initWithRootViewController:shopVC];
                shopNavc.navigationBarHidden = YES;
                [self pushAnimationWithProcess:shopNavc];
                
            }
                break;
            case 2:
            {
                BookingViewController * shopVC = [[BookingViewController alloc] init];
                UINavigationController * shopNavc = [[UINavigationController alloc]initWithRootViewController:shopVC];
                shopNavc.navigationBarHidden = YES;
                
                [self pushAnimationWithProcess:shopNavc];
                
            }
                
                break;
            default:
                break;
        }

    }else{
        //未登录时首页
        ShopViewController * shopVC = [[ShopViewController alloc] init];
        shopVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
        UINavigationController * shopNavc = [[UINavigationController alloc]initWithRootViewController:shopVC];
        shopNavc.navigationBarHidden = YES;
        [self pushAnimationWithProcess:shopNavc];
        
        switch (selectedIndex) {
            case 0:
                
//                [self pushToLoginView];
                break;
                case 1:
                [self pushToLoginView];
                break;
                case 2:
                [self pushToLoginView];
                break;
            default:
                break;
        }


    }

    self.centerView.clipsToBounds = YES;
    [self.view bringSubviewToFront:_tabarView];

    
}

//push动画
- (void)pushAnimationWithProcess:(UINavigationController *)navc
{
        navc.view.frame = CGRectMake(290, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
        
        [UIView animateWithDuration:0.1 animations:^{
            
            navc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT - 50);
            [self addChildViewController:navc];
            [self.centerView addSubview:navc.view];
            
            _curentNavc.view.frame = CGRectMake(- SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20);
            
        } completion:^(BOOL finished) {
            
            if (_curentNavc != nil) {
                [_curentNavc.view removeFromSuperview ];
                [_curentNavc removeFromParentViewController];
                self.curentNavc = nil;
            }
            
            _curentNavc = navc;
            
            
        }];

    

}



- (void)tabBarHidden
{
    [UIView animateWithDuration:0.5 animations:^{
        _tabarView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, TAB_BAR_TAG_BASE);
    }];
    
}

- (void)tabBarShow
{
    [UIView animateWithDuration:0.5 animations:^{
        _tabarView.frame = CGRectMake(0, SCREEN_HEIGHT - 50 , SCREEN_WIDTH, TAB_BAR_TAG_BASE);

    }];
}

- (void)moveLeftView:(NSNotification *)notifyation
{
    ((UILabel *)[self.view viewWithTag:10000]).text = [NSString stringWithFormat:@"您好! %@\n\n欢迎登录太平人寿卓越客户体验服务平台",[ModelData shearInstance].userName];
    NSLog(@"%@",[ModelData shearInstance].userName);

    [UIView animateWithDuration:0.3 animations:^{
        _leftView.frame = CGRectMake(_leftView.frame.origin.x == -PERSONAL_WIDTH ? 0 : -PERSONAL_WIDTH, 64, PERSONAL_WIDTH, SCREEN_HEIGHT - 64 - TAB_BAR_HEIGHT);
  
    }];

}

- (void)pushToLoginView
{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];

}
#pragma mark - 个人中心
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
    AgentViewController * agentVC = [[AgentViewController alloc] init];
    [self.navigationController pushViewController:agentVC animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_HIDDEN object:self];
    
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

@end
