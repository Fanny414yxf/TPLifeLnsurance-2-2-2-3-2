//
//  ClassificationCollectionViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-4.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "ClassificationCollectionViewCell.h"

@interface ClassificationCollectionViewCell ( )
@property (nonatomic,strong)UIButton * button;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * className;
@property (nonatomic,strong)UILabel * detail;

@end

@implementation ClassificationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, -10, 130, 80)];
//        [_button setImage:[UIImage imageNamed:@"anjuke_icon_to_position1@2x.png"] forState:UIControlStateNormal];
//        _button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60);
//        [self.contentView addSubview:_button];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _imageView.layer.cornerRadius = 5;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_imageView];
        

        _className = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 90, 20)];
        _className.text = @"旅游";
        _className.textColor = [UIColor grayColor];
        [self.contentView addSubview:_className];
        
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 90, 40)];
        _detail.text = @"dgfjds";
        _detail.font = FONT(14);
        _detail.textColor = [UIColor grayColor];
        _detail.numberOfLines = 2;
        _detail.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;//文本最上端与Label中线对齐,默认值
//        _detail.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_detail];
        
        
    }
    return self;
}


- (void)setClassItemContentWithInfo:(NSDictionary *)info
{
//    [_button setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:IMAGE_URL(info[@"imgUrl"])]]] forState:UIControlStateNormal];
    _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:IMAGE_URL(info[@"imgUrl"])]]];
    _className.text = info[@"displayName"];
    _detail.text = info[@"categoryDescription"];
}




@end
