//
//  DetailClassTableViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-5.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "DetailClassTableViewCell.h"
@interface  DetailClassTableViewCell ()

@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * priceVIP;


@end


@implementation DetailClassTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
        _photoImage.backgroundColor = [UIColor greenColor];
        _photoImage.layer.cornerRadius = 5;
        _photoImage.layer.cornerRadius = 5;
        _photoImage.clipsToBounds = YES;
        [self.contentView addSubview:_photoImage];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100, 30)];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = FONT(22);
        [self.contentView addSubview:_nameLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 65, 100, 20)];
        _priceLabel.textColor = [UIColor grayColor];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = FONT(16);
        [self.contentView addSubview:_priceLabel];

        _priceVIP = [[UILabel alloc] initWithFrame:CGRectMake(150, 90, 100, 20)];
        _priceVIP.textColor = [UIColor grayColor];
        _priceVIP.textAlignment = NSTextAlignmentLeft;
        _priceVIP.font = FONT(16);
        [self.contentView addSubview:_priceVIP];

        
    }
    return self;
}


- (void)setCellContentWithInfo:(NSDictionary *)info
{
    
    _photoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:IMAGE_URL(info[@"imgUrl"])]]];
    _nameLabel.text = info[@"displayName"];
    _priceLabel.text = [NSString stringWithFormat:@"市场价:%@",info[@"marketPrice"]];
    _priceVIP.text = [NSString stringWithFormat:@"会员价:请登录查看"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
