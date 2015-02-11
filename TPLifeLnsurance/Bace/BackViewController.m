//
//  BackViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-5.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "BackViewController.h"

@interface BackViewController ()


@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVC_HIGTH)];
    _navcView.backgroundColor = COLOR(42, 79, 160, 1);
    _navcView.userInteractionEnabled = YES;
    [self.view addSubview:_navcView];
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
    _backButton.imageView.image = IMAGE_WITH_NAME(@"返回.png");
    [_backButton addTarget:self action:@selector(GoHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 100, 40)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = FONT(20);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    
    
}

- (void)GoHome:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
