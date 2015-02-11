//
//  DescriptionView.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-7.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "DescriptionView.h"

@interface DescriptionView ()

@property (nonatomic,strong)UIView * backgroundView;


@end

@implementation DescriptionView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSArray * descriptionArray = @[@"商户名称: ",@"商户地址:",@"商户介绍:",@"人均消费:",@"招牌服务:",@"停车环境:"];
        
        for (int i = 0; i < 6; i ++) {
            UIImageView * line  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 350, 1)];
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
            UILabel * description = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 25)];
            description.font = [UIFont systemFontOfSize:15];
            description.numberOfLines = 0;
            description.font = [UIFont systemFontOfSize:20];
            description.backgroundColor = [UIColor clearColor];
            description.tag = 700 + i;
            description.font = [UIFont systemFontOfSize:18];
            description.text = descriptionArray[i];
            [self addSubview:description];
            
            UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 250, 25)];
            detail.numberOfLines = 0;
            detail.font = [UIFont systemFontOfSize:16];
            detail.backgroundColor = [UIColor clearColor];
            detail.tag = 800 + i;
            [self addSubview:detail];
            if (i == 1) {
                description.frame = CGRectMake(10, 30, 85, 25);
                detail.frame = CGRectMake(100, 30, 250, 50);
                line.frame = CGRectMake(0, 90, 350, 1);
                
            }else if (i == 2)
            {
                description.frame = CGRectMake(10, 90, 85, 25);
                detail.frame = CGRectMake(100, 90, 250, 500);
                line.frame = CGRectMake(0, 590, 350, 1);
            }else if (i == 3)
            {
                description.frame = CGRectMake(10, 590, 85, 25);
                detail.frame = CGRectMake(100, 590, 250, 25);
                line.frame = CGRectMake(0, 620, 350, 1);

            }else if (i == 4)
            {
                description.frame = CGRectMake(10, 620, 85, 25);
                detail.frame = CGRectMake(100, 620, 250, 25);
                line.frame = CGRectMake(0, 650, 350, 1);

            }else if (i == 5)
            {
                description.frame = CGRectMake(10, 650, 85, 25);
                detail.frame = CGRectMake(100, 650, 250, 25);
            }

        }
        
    }
    return self;
    
}

- (void)setDetailInformation:(NSArray *)info
{
    for (int i = 0; i < 6; i ++) {
        ((UILabel *)[self viewWithTag:800 + i]).text = [NSString stringWithFormat:@"%@",info[i]];
        
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
