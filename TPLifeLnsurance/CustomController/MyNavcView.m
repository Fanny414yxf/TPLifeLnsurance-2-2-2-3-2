//
//  MyNavcView.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-3.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MyNavcView.h"

@interface MyNavcView ()

@property (nonatomic,strong)UIButton * comeBackButton;

@end
@implementation MyNavcView

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)]) {
        
        UIImageView * navc = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        navc.backgroundColor  = COLOR(23, 62, 123, 1);
        [self addSubview:navc];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        [navc addSubview:titleLabel];
        _comeBackButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
        [_comeBackButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        [navc addSubview:_comeBackButton];

        
       
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
