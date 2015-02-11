//
//  BookingDetailVCViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-9.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "BookingDetailVCViewController.h"

@interface BookingDetailVCViewController ()

@property (nonatomic,strong)UIView * backgroundView;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UIView * line;
@property (nonatomic,strong)UIButton * button;
@property (nonatomic,strong)UIView * grayView;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UILabel * money;
@property (nonatomic,strong)UILabel * moneyNumber;
@property (nonatomic,strong)UIView * footView;
@property (nonatomic,strong)UILabel * totalPrice;

@property (nonatomic,strong)NSMutableDictionary * dataSource;


@end

@implementation BookingDetailVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self upBookingDetaioRequest];
    [self initUserInterface];
}

- (void)initUserInterface
{
    
    self.titleLabel.text = @"订单详情";
    [self.backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(processBackButton) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = COLOR(236, 236, 236, 1);
    
    _dataSource = [[NSMutableDictionary alloc] init];
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 70)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backgroundView];
    
    NSArray * array = @[@"订单编号:",@"创建时间:",@"订单类型:",@"订单状态:", @"代理人:", @"备注:"];
    NSArray * array1 = @[@"待处理", @"已处理", @"已完成"];
    
    for (int i = 0; i < 6; i ++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        label.text = array[i];
        label.font = FONT(14);
        label.textColor = [UIColor grayColor];
        [_backgroundView addSubview:label];
        
        if (i == 3) {
            label.frame = CGRectMake(10, 185, 80, 20);
            label.font = FONT(14);
        }else if (i == 4){
            label.frame = CGRectMake(10, 270, 60, 20);
        }else if (i == 5){
            label.frame = CGRectMake(10, 350, 60, 20);
        }else{
            label.frame = CGRectMake(10, 5 + i * 25, 60, 20);
        }
    }
    
    for (int i = 0; i < 5; i ++) {
        UILabel * detailLabel = [[UILabel alloc] init];
        detailLabel.font = FONT(16);
        detailLabel.tag = 3000 + i;
        [_backgroundView addSubview:detailLabel];
        
        if ( i == 3) {
            detailLabel.frame = CGRectMake(130, 95, 170, 20);
        }else if (i == 4){
            detailLabel.frame = CGRectMake(100, 153, 300, 20);
        }else{
            detailLabel.frame = CGRectMake(100,  5 + 25 * i, 160, 20);
        }
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 95, 80, 80)];
    _imageView.backgroundColor = [UIColor grayColor];
    [_backgroundView addSubview:_imageView];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(25, 220, 240, 0.7)];
    _line.backgroundColor = COLOR(0, 57, 146, 1);
    [_backgroundView addSubview:_line];
    
    for (int i = 0; i < 3; i ++) {
        UIImageView * stastusImge = [[UIImageView alloc] init];
        stastusImge.frame = CGRectMake((17 + (120 * i)), 208, 25, 25);
        stastusImge.image = IMAGE_WITH_NAME(@"btn_waiProcess.png");
        [_backgroundView addSubview:stastusImge];

        UILabel * statusLabel = [[UILabel alloc]initWithFrame:CGRectMake((8 + (120 * i)), 230, 50, 20)];
        statusLabel.text = array1[i];
        statusLabel.textColor = COLOR(0, 57, 146, 1);
        statusLabel.font = [UIFont systemFontOfSize:15];
        [_backgroundView addSubview:statusLabel];
        
        if (i == 0) {
            stastusImge.image = IMAGE_WITH_NAME(@"btn_porcessingDot.png");
            statusLabel.textColor = [UIColor orangeColor];
        }
    }
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(60, 270, 100, 20)];
    _name.text = @"快捷键";
    [_backgroundView addSubview:_name];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(10, 300, 105, 30)];
    _button.layer.borderWidth = 1;
    _button.layer.borderColor = [COLOR(45, 148, 17, 1)CGColor];
    _button.layer.cornerRadius = 5;
    [_button setTitle:@"联系他" forState:UIControlStateNormal];
    [_button setTitleColor:COLOR(45, 148, 17, 1) forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(processContactButton) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_button];
    
//    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 55, SCREEN_WIDTH, 55)];
//    _grayView.backgroundColor = COLOR(201, 205, 203, 1);
//    [_backgroundView addSubview:_grayView];
//    
//    _money = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 100, 20)];
//    _money.text = @"总金额:";
//    [_grayView addSubview:_money];
//    
//    _moneyNumber = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 20)];
//    _moneyNumber.font = [UIFont systemFontOfSize:21];
//    _moneyNumber.textColor = [UIColor orangeColor];
//    [_grayView addSubview:_moneyNumber];
    
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TAB_BAR_HEIGHT - 130, SCREEN_WIDTH, 60)];
    _footView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    [_backgroundView addSubview:_footView];
    
    UILabel * money = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 100, 20)];
    money.text = @"总金额:";
    money.textColor = [UIColor blackColor];
    [_footView addSubview:money];
    
    _totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
    _totalPrice.textColor = [UIColor orangeColor];
    [_footView addSubview:_totalPrice];
    
    
    
    
    
}



- (void)processContactButton
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未找到联系方式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)upBookingDetaioRequest
{
    [NetWork sendAllBookingDetailRequestWithOrderid:self.orderId userType:1 token:[ModelData shearInstance].token callback:^(id result) {
        NSLog(@"订单详情页%@",result);
        
        _dataSource = result[@"data"];
        [self refreshView];
    }];
}

- (void)refreshView
{
    for (int i = 0; i < 5; i ++) {
        UILabel * detailLabel = (UILabel *)[self.view viewWithTag:3000 + i];
        if (detailLabel.tag == 3000) {
            detailLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"orderNo"]];
            detailLabel.textColor = [UIColor orangeColor];
        }else if (detailLabel.tag == 3001){
            detailLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"createTime"]];
        }else if (detailLabel.tag == 3002){
            if ([_dataSource[@"orderType"]integerValue] == 2) {
                detailLabel.text = @"预定购买";
            }else{
                detailLabel.text = @"预约了解";
            }
            
        }else if (detailLabel.tag == 3003){
            detailLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"goodsName"]];

        }else if (detailLabel.tag == 3004){
            detailLabel.text = [NSString stringWithFormat:@"价格: ￥ %@ 数量:%@",[NSString stringWithFormat:@"%@",_dataSource[@"totalPrice"] ],_dataSource[@"goodsNumber"]];
        }
    }
    
    NSString * str = [NSString stringWithFormat:@"http://192.168.7.56:8090/tpl%@",_dataSource[@"imgUrl"]];
    NSString * newStr = [str stringByReplacingOccurrencesOfString:@"\\" withString:@"//"];
    _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newStr]]];
    
    _totalPrice.text = [NSString stringWithFormat:@"￥ %@",_dataSource[@"totalPrice"]];
    [self.view bringSubviewToFront:_totalPrice];
 
}

- (void)processBackButton
{
   [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_SHOW object:self]; 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
