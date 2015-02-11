//
//  MassegeViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MassegeViewController.h"
#import "CycleScrollView.h"

@interface MassegeViewController ()<CycleScrollViewDatasource,CycleScrollViewDelegate>

@end

@implementation MassegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor cyanColor];
//    self.contentView.backgroundColor = [UIColor yellowColor];
    
    [self userInterface];
}

- (void)userInterface
{
    UIButton * newMassegeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 30, 30, 30)];
    [newMassegeButton setImage:[UIImage imageNamed:@"新建消息.png"] forState:UIControlStateNormal];;
    [self.navc addSubview:newMassegeButton];
    
    UILabel * titlieLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 50, 25)];
    titlieLabel.text = @"消息";
    titlieLabel.textColor = [UIColor whiteColor];
    titlieLabel.font = FONT(24);
    [self.navc addSubview:titlieLabel];
    
    CycleScrollView * scrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200) withDatasourseAndDelegate:self];
    scrollView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:scrollView];

}


#pragma mark - <CycleScrollViewDatasource,CycleScrollViewDelegate>
- (NSInteger)numberOfPages
{
    return 8;
}
- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    imageVeiw.image = IMAGE_WITH_NAME(@"返回.png");
//    [self.contentView addSubview:imageVeiw];
    return imageVeiw;
    
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
