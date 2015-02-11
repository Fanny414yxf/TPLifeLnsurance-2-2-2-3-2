//
//  TabarView.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "TabarView.h"

#define WIDTH_BUTTON SCREEN_WIDTH / 3
#define POINT_ONE CGPointMake(WIDTH_BUTTON / 2, self.bounds.size.height/2)
#define POINT_TOW  CGPointMake(WIDTH_BUTTON / 2 + WIDTH_BUTTON, self.bounds.size.height/2)
#define POINT_THREE  CGPointMake(WIDTH_BUTTON / 2 + 2 * WIDTH_BUTTON, self.bounds.size.height/2)

@interface  TabarView ()

@property (nonatomic,strong)UIView * selectedView;
;
@end


@implementation TabarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializationUserInterface];
        
        
        //接收通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifySwitchTabBar:) name:NOTIFY_SWITCH_TAB_BAR object:nil];

    }
    return self;
}

- (void)initializationUserInterface
{
    
    
    CGFloat buttonWidth = SCREEN_WIDTH / 3;
    
    
    
    NSArray * arrayImage = @[@"商品.png",@"消息.png",@"订单.png"];
    NSArray * arrayLabel = @[@"商品浏览",@"我的消息",@"我的订单"];

    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0,0, buttonWidth, 50)];
    _selectedView.backgroundColor = COLOR(42,79, 160, 0.5);
    [self addSubview:_selectedView];
    
    for (int i = 0; i < 3; i ++) {
        UIButton * button  = [[UIButton alloc]initWithFrame:CGRectMake(10 + buttonWidth * i, 0, buttonWidth - 20, 50)];
        [button setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
        //button图片位置 上 左 下 右
        button.imageEdgeInsets = UIEdgeInsetsMake(5, 30, 20, 30);
        button.titleLabel.font = FONT(16);
        button.titleLabel.textColor = COLOR(222,144,33,1);
        button.tag = TAB_BAR_TAG_BASE + i;
        [button addTarget:self action:@selector(buttonPrecess:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30 + buttonWidth * i, 30, buttonWidth - 10, 20)];
        label.text = arrayLabel[i];
        label.textColor = [UIColor whiteColor];
        label.font = FONT(16);
        [self addSubview:label];
        
        
    }

}

- (void)buttonPrecess:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _selectedView.center = sender.center;
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarDidSelectedWithIndex:)]) {
        [_delegate tabBarDidSelectedWithIndex:sender.tag - TAB_BAR_TAG_BASE];
    }
    
    
}

- (void)resetButtonState
{
    for (int i = 0; i < 3; i ++) {
        UIButton * button = (UIButton *)[self viewWithTag:TAB_BAR_TAG_BASE + i];
        button.selected = NO;
    }
}


#pragma mark --通知要做的事
- (void)notifySwitchTabBar:(NSNotification *)notifucatiaon
{
    
    NSInteger index = [[notifucatiaon object] integerValue];
    [self buttonPrecess:(UIButton *)[self viewWithTag:TAB_BAR_TAG_BASE + index]];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
