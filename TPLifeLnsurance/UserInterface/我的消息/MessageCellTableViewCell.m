//
//  MessageCellTableViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-7.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MessageCellTableViewCell.h"

@implementation MessageCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (int i = 0; i < 4; i ++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
            label.tag = 600 + i;
            [self.contentView addSubview:label];
            if (i == 0) {
                label.backgroundColor = [UIColor grayColor];
                label.text = @"联系人";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
            }else if (i == 1){
                label.frame = CGRectMake(80, 10, 60, 30);
                label.textColor = [UIColor blackColor];
            }else if (i == 2){
                label.frame = CGRectMake(220, 15, 150, 20);
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = [UIColor grayColor];
            }else if (i == 3){
                label.frame = CGRectMake(10, 60, 300, 80);
                label.font = [UIFont systemFontOfSize:18];
                label.numberOfLines = 0;
            }
            

        }
    }
    return self;
}



- (void)setCellContentWithInfo:(NSDictionary *)info
{

    for (int i = 0; i < 4; i ++) {
        
        UILabel * label = (UILabel *)[self viewWithTag:600 + i];
        if (label.tag == 601) {
            label.text = info[@"senderName"];
        }else if (label.tag == 602)
        {
            label.text = info[@"sentTime"];
        }else if (label.tag == 603){
            label.text = info[@"content"];

        }
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
