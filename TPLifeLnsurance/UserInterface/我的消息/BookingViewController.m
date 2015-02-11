//
//  BookingViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.contentView.backgroundColor = [UIColor yellowColor];
    [self initailzeInterface];
}





- (void)initailzeInterface
{
    UILabel * titlieLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 100, 25)];
    titlieLabel.text = @"我的订单";
    titlieLabel.textColor = [UIColor whiteColor];
    titlieLabel.font = FONT(23);
    [self.navc addSubview:titlieLabel];
}






























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
