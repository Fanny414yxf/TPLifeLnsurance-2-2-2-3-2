//
//  BookingTableViewCell.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-9.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "BookingTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface BookingTableViewCell ()

@property (nonatomic,strong)UIView * view;
@property (nonatomic,strong)UILabel * detailLabel;
@property (nonatomic,strong)UILabel * creatTime;
@property (nonatomic,strong)UILabel * bookingType;
@property (nonatomic,strong)UILabel * goodsName;
@property (nonatomic,strong)UILabel * price;
@property (nonatomic,strong)UILabel * number;
@property (nonatomic,strong)UIImageView * goodsImage;

//订单状态
@property (nonatomic,strong)UIImageView * bookingStatusView;
@property (nonatomic,strong)UIImageView * line;
@property (nonatomic,strong)UILabel * status;
@property (nonatomic,strong)UIImageView * statusLog;
@property (nonatomic,strong)UIImageView * statusLogOther;


@end

@implementation BookingTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 350, 300)];
//        _view.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_view];
        
        NSArray * labelArray = @[@"订单编号:",@"创建时间:",@"订单类型:",@"name",@"价格:",@"数量:"];
        for (int i = 0; i < 6; i ++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + i * 25, 90, 22)];
            label.text = labelArray[i];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:16];
            [_view addSubview:label];
            
            _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10 + i * 25, 200, 20)];
            _detailLabel.font = [UIFont systemFontOfSize:16];
            _detailLabel.tag = 2000 + i;
            [_view addSubview:_detailLabel];
            
            if (i == 0) {
                _detailLabel.textColor = [UIColor orangeColor];
                
            }else if (i == 3) {
                _detailLabel.frame = CGRectMake(150, 110, 200, 20);
                label.hidden = YES;

            }else if (i == 4){
                label.frame = CGRectMake(110, 150, 40, 20);
                _detailLabel.frame = CGRectMake(150, 150, 90, 20);
                _detailLabel.textColor = [UIColor orangeColor];


            }else if (i == 5 ){
                label.frame = CGRectMake(250, 150,40, 20);
                _detailLabel.frame = CGRectMake(300, 150, 220, 20);
                _detailLabel.textColor = [UIColor blackColor];
                
            }
        }
        
        
        _goodsImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 90, 90)];
        _goodsImage.backgroundColor = [UIColor redColor];
        [_view addSubview:_goodsImage];
        UILabel * statesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 90, 20)];
        statesLabel.font = [UIFont systemFontOfSize:18];
        statesLabel.textColor = [UIColor blackColor];
        [_view  addSubview:statesLabel];
        
        UIView * spaceView = [[UIView alloc] initWithFrame:CGRectMake(-10, 270, SCREEN_WIDTH, 30)];
        spaceView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_view addSubview:spaceView];
        
        
#pragma mark - 状态
        _bookingStatusView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 205, 280, 60)];
//        _bookingStatusView.image = IMAGE_WITH_NAME(@"待处理.png");
        [_view addSubview:_bookingStatusView];
        _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 280, 1)];
        _line.backgroundColor = [UIColor orangeColor];
        [_bookingStatusView addSubview:_line];
        
        NSArray * statusArray = @[@"待处理",@"已处理",@"已取消"];
        for (int i = 0; i < 3; i++ ) {
            _statusLog = [[UIImageView alloc] initWithFrame:CGRectMake(0 + 120 * i, 10, 20, 20)];
            _statusLog.image = IMAGE_WITH_NAME(@"btn_porcessingDot.png");
            if (i >= 1) {
                _statusLog.hidden = YES;
                _statusLog.backgroundColor = [UIColor grayColor];
                _statusLogOther.hidden = NO;
            }
            [_bookingStatusView addSubview:_statusLog];
            
            
            _statusLogOther = [[UIImageView alloc] initWithFrame:CGRectMake(0 + 130 * i, 10, 10, 10)];
            _statusLogOther.backgroundColor = COLOR(39, 65, 140, 1);
            _statusLogOther.layer.cornerRadius = 5;
            [_bookingStatusView addSubview:_statusLogOther];
            

            _status = [[UILabel alloc] initWithFrame:CGRectMake(10 + 110 * i, 30, 60, 30)];
            _status.textColor = [UIColor orangeColor];
            _status.text = statusArray[i];
            [_bookingStatusView addSubview:_status];
        }
        
        
        
    }
    return self;
}

- (void)setBookingCellContentWithInfo:(NSDictionary *)info
{
    NSString * newStr = [NSString stringWithFormat:@"%@",info[@"imgUrl"]];
    NSString * string =[newStr stringByReplacingOccurrencesOfString:@"\\" withString:@"//"];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:IMAGE_URL(string)]];
        for (int i = 0; i < 6; i ++) {
        UILabel * label = (UILabel *)[self.view viewWithTag:2000 + i];
        if (label.tag == 2000) {
            
            label.text = [NSString stringWithFormat:@"%@",info[@"orderNo"]];
            
        }else if (label.tag == 2001){
            
            label.text = [NSString stringWithFormat:@"%@",info[@"createTime"]];

        }else if (label.tag == 2002){
            
            label.text = @"预定购买";
            
        }else if (label.tag == 2003){
            
            label.text = [NSString stringWithFormat:@"%@",info[@"goodsName"]];

        }else if (label.tag == 2004){
            
            label.text = [NSString stringWithFormat:@"￥%@",info[@"goodsPrice"]];
            
        }else if(label.tag == 2005){
            
            label.text = [NSString stringWithFormat:@"%@",info[@"goodsNumber"]];
        }
            
    }
    
    if ([info[@"orderType"] integerValue] != 2) {
        _statusLogOther.hidden = YES;
        _statusLog.hidden = YES;
    }else{
        _statusLog.hidden = YES;
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
