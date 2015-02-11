//
//  RecommendMerchantCollectionViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-4.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "RecommendMerchantCollectionViewCell.h"

@interface RecommendMerchantCollectionViewCell ()

@property (nonatomic,strong)UIButton * button;
@property (nonatomic,strong)UIView * imageView;
@property (nonatomic,strong)UILabel * nameLabel;



@end

@implementation RecommendMerchantCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 80)];
        _imageView.layer.cornerRadius = 5;
        _imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 100, 25)];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.font = FONT(18);
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}

- (void)setcontentItemWithInfo:(NSDictionary *)info
{
    _nameLabel.text = info[@"displayName"];
}

@end
