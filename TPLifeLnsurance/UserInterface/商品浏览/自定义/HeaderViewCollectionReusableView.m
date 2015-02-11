//
//  HeaderViewCollectionReusableView.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-4.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "HeaderViewCollectionReusableView.h"

@interface HeaderViewCollectionReusableView ()

@property (nonatomic,strong)UIImageView * view;
@property (nonatomic,strong)UIButton * moreButton;


@end

@implementation HeaderViewCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
//        _view.image = IMAGE_WITH_NAME(@"title.png");
        [self addSubview:_view];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 100, 40)];
        _title.text = @"商品分类";
        _title.font = FONT(23);
        _title.textColor =[UIColor grayColor];
        [_view addSubview:_title];
        
        _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 30)];
        [_moreButton setImage:[UIImage imageNamed:@"F2B7TG~KY9TDRH$SIKQ3EH1.jpg"] forState:UIControlStateNormal];
        [_view addSubview:_moreButton];
        
    }
    return self;
}

@end
