//
//  RecommendGoodsCollectionViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-4.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "RecommendGoodsCollectionViewCell.h"
@interface   RecommendGoodsCollectionViewCell ()
@property (nonatomic,strong)UIButton * button;
@property (nonatomic,strong)UIScrollView * detailScrollViwe;
@property (nonatomic,strong)UILabel * goodsName;
@property (nonatomic,strong)UILabel * price;
@property (nonatomic,strong)UILabel * pirceVIP;

@end

@implementation RecommendGoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 85, 100)];
        [_button setImage:[UIImage imageNamed:@"anjuke_icon_to_position1@2x.png"] forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;
        _button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 40, 0);
        [self.contentView addSubview:_button];
        
        _detailScrollViwe = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, 120, 40)];
        _detailScrollViwe.contentSize = CGSizeMake(120, 80);
        _detailScrollViwe.pagingEnabled = YES;
        [self.contentView addSubview:_detailScrollViwe];
        _goodsName = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 100, 20)];
        _goodsName.text = @"ios";
        _goodsName.font = FONT(14);
        _goodsName.textAlignment = NSTextAlignmentCenter;
        _goodsName.textColor = [UIColor grayColor];
        [_detailScrollViwe addSubview:_goodsName];
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 100, 20)];
        _price.text = @"150";
        _price.textAlignment = NSTextAlignmentCenter;
        _price.textColor = [UIColor grayColor];
        _price.font = FONT(16);
        [_detailScrollViwe addSubview:_price];

        _pirceVIP = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 20)];
        _pirceVIP.text = @"vip100";
        _pirceVIP.font = FONT(16);
        _pirceVIP.textAlignment = NSTextAlignmentCenter;
        _pirceVIP.textColor = [UIColor orangeColor];
        [_detailScrollViwe addSubview:_pirceVIP];

        
        
    }
    return self;
}

- (void)setItemContentWithInfo:(NSDictionary *)info
{

    [_button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:IMAGE_URL(info[@"imgUrl"])]]] forState:UIControlStateNormal];
    
    _goodsName.text = info[@"displayName"];
    _price.text = [NSString stringWithFormat:@"市场价:%@",info[@"marketPrice"]];
    _pirceVIP.text = [NSString stringWithFormat:@"会员价:%@",info[@"marketPrice"]];

}

@end
