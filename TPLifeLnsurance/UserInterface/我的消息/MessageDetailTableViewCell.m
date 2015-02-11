//
//  MessageDetailTableViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-7.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MessageDetailTableViewCell.h"

@interface MessageDetailTableViewCell ()

@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UIImageView * imageview;

@end

@implementation MessageDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 150, 20)];
        _timeLabel.text = @"12-03-22  15:22";
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_timeLabel];
        
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 100, 50)];
        _imageview.image = IMAGE_WITH_NAME(@"chatto_bg_normal.png");
        [self.contentView addSubview:_imageview];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.numberOfLines = 5;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_imageview addSubview: _contentLabel];
        
        
        
    }
    return self;
}

- (void)sendMessageDetailContentWinthInfo:(NSDictionary *)info size_x:(NSInteger)size_w size_h:(NSInteger)size_h
{
    
    _timeLabel.text = info[@"sentTime"];
    _contentLabel.frame = CGRectMake(10, 0, size_w + 20, size_h + 20);
    _imageview.frame = CGRectMake(SCREEN_WIDTH - size_w - 70, 30, size_w + 50, size_h + 30);
    _contentLabel.text = [NSString stringWithFormat:@"%@",info[@"content"]];
    
}

- (void)setCellSystemMessageDetailContentWithInfo:(NSDictionary *)info size_x:(NSInteger)size_w size_h:(NSInteger)size_h
{
    _imageview.image = IMAGE_WITH_NAME(@"chatfrom_bg_normal.png");
    _timeLabel.frame = CGRectMake(40, 10, 150, 30);
    _timeLabel.text = info[@"sentTime"];
    _contentLabel.frame = CGRectMake(10, 0, size_w + 20, size_h + 20);
    _imageview.frame = CGRectMake(0, 30, size_w + 50, size_h + 30);
    _contentLabel.text = [NSString stringWithFormat:@"%@",info[@"content"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
