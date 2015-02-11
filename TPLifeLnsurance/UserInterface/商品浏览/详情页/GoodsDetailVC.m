//
//  GoodsDetailVC.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-6.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "ScrollView.h"

@interface GoodsDetailVC ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * scroll;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UILabel * price;
@property (nonatomic,strong)NSMutableArray * imageArr;
@property (nonatomic,strong)ScrollView * photoScrollView;
@property (nonatomic,strong)UILabel * topLabel;//优惠
@property (nonatomic,strong)UILabel * top_detailLabel;
@property (nonatomic,strong)UILabel * topTime_detailLabel;

@property (nonatomic,strong)UILabel * desriptionLabel;//商品描述
@property (nonatomic,strong)UILabel * desription_detailLabel;

@property (nonatomic,strong)UILabel * goodsAddress;
@property (nonatomic,strong)UILabel * goodsAddress_detail;

@property (nonatomic,strong)UILabel * merchantIntruduce;
@property (nonatomic,strong)UIView * merchanrIntruduce_detailView;
@property (nonatomic,strong)UILabel * merchantName;
@property (nonatomic,strong)UILabel * merchnatAddress;
@property (nonatomic,strong)UILabel * merchanr;

@property (nonatomic,strong)NSMutableDictionary * dataSource;



@end


@implementation GoodsDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self goodSDetilRefresh];
    [self initUserInterface];
}

- (void)initUserInterface
{
    self.titleLabel.text = @"商品详情";
    [self.backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVC_HIGTH, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.view addSubview:_scroll];
    
    _photoScrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _photoScrollView.backgroundColor = [UIColor grayColor];
    [_scroll addSubview:_photoScrollView];
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, 220, 150, 25)];
    _name.center = CGPointMake(CGRectGetMidX(self.view.bounds), 230);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.text = @"捷安特ATX770";
    _name.font = FONT(17);
    [_scroll addSubview:_name];
    
    
    _price = [[UILabel alloc] initWithFrame:CGRectMake(15, 250, 360, 20)];
    _price.textColor = [UIColor grayColor];
    _price.font = FONT(14);
    [_scroll  addSubview:_price];
    
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 290, 360, 20)];
    _topLabel.text = @"优惠信息";
    _topLabel.textColor = COLOR(0, 57, 146, 1);
    [_scroll addSubview:_topLabel];
    
    _top_detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 320, 380, 80)];
    _top_detailLabel.textColor = [UIColor grayColor];
    _top_detailLabel.font = FONT(14);
    _top_detailLabel.numberOfLines = 0;
    _top_detailLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    _top_detailLabel.layer.borderWidth = 1;
    _top_detailLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    [_scroll  addSubview:_top_detailLabel];
    
    _desriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 420, 400, 20)];
    _desriptionLabel.text = @"商品描述";
    _desriptionLabel.font = FONT(16);
    _desriptionLabel.textColor = COLOR(0, 57, 146, 1);
    [_scroll addSubview:_desriptionLabel];
    
    _desription_detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 450, 360, 150)];
    _desription_detailLabel.textColor = [UIColor grayColor];
    _desription_detailLabel.font = FONT(14);
    _desription_detailLabel.numberOfLines = 0;
    _desription_detailLabel.layer.borderWidth = 1;
    _desription_detailLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    [_scroll  addSubview:_desription_detailLabel];
    
    _goodsAddress = [[UILabel alloc] initWithFrame:CGRectMake(5, 620, 80, 20)];
    _goodsAddress.text = @"商品地址";
    _goodsAddress.font = FONT(16);
    _goodsAddress.textColor = COLOR(0, 57, 146, 1);
    [_scroll addSubview:_goodsAddress];
    
    _goodsAddress_detail = [[UILabel alloc] initWithFrame:CGRectMake(5, 640, 360, 50)];
    _goodsAddress_detail.textColor = [UIColor grayColor];
    _goodsAddress_detail.font = FONT(16);
    _goodsAddress_detail.layer.borderWidth = 1;
    _goodsAddress_detail.layer.borderColor = [[UIColor grayColor]CGColor];
    [_scroll  addSubview:_goodsAddress_detail];
    
    _merchantIntruduce = [[UILabel alloc] initWithFrame:CGRectMake(5, 700, 80, 20)];
    _merchantIntruduce.text = @"商户介绍";
    _merchantIntruduce.font = FONT(16);
    _merchantIntruduce.textColor = COLOR(0, 57, 146, 1);
    [_scroll addSubview:_merchantIntruduce];
    
    
    _merchanrIntruduce_detailView = [[UIView alloc] initWithFrame:CGRectMake(5, 725,360, 600)];
    _merchanrIntruduce_detailView.layer.borderColor = [[UIColor grayColor]CGColor];
    _merchanrIntruduce_detailView.layer.borderWidth = 1;
    [_scroll addSubview:_merchanrIntruduce_detailView];
    
    NSArray * array = @[@"商户名称:",@"商户地址:",@"商户介绍:"];
    for (int i = 0; i < 3; i ++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5 + i * 30, 100, 25)];
        label.text = array[i];
        [_merchanrIntruduce_detailView addSubview:label];

    }

    _merchantName = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 220, 20)];
    _merchantName.textColor = [UIColor grayColor];
    _merchantName.font = FONT(16);
    [_merchanrIntruduce_detailView addSubview:_merchantName];
    
    _merchnatAddress = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 250, 50)];
    _merchnatAddress.textColor = [UIColor grayColor];
    _merchnatAddress.font = FONT(16);
    _merchnatAddress.numberOfLines = 0;
    [_merchanrIntruduce_detailView addSubview:_merchnatAddress];
    
    _merchanr = [[UILabel alloc] initWithFrame:CGRectMake(110, 75, 250, 500)];
    _merchanr.textColor = [UIColor grayColor];
    _merchanr.font = FONT(16);
    _merchanr.numberOfLines = 0;
    [_merchanrIntruduce_detailView addSubview:_merchanr];
    
     
}

- (void)goodSDetilRefresh
{
    [NetWork sendGoodsDetailRequestWithGoodid:self.goodsId token:[ModelData shearInstance].token callback:^(id result) {
        NSLog(@"商品详情%@",result);
        
        _dataSource = [[NSMutableDictionary alloc] init];
        _dataSource = result[@"data"];
        NSMutableDictionary * dic  =[[NSMutableDictionary alloc] init];
        NSMutableArray * imgaeArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 4; i ++) {
            [imgaeArray addObject:[NSString stringWithFormat:@"http://192.168.7.56:8090/tpl%@", result[@"data"][@"imageUrls"][i]]];
            NSLog(@"%@",imgaeArray[i]);
        }
        [dic setObject:imgaeArray forKey:@"image"];
        [_photoScrollView setScrollViewInfo:dic];

        [self upData];
    }];
}

- (void)upData
{
    _name.text = _dataSource[@"displayName"];
    _price.text = [NSString stringWithFormat:@"市场价: ￥%@　　　　　　会员价: ￥%@",_dataSource[@"marketPrice"],_dataSource[@"marketPrice"]];
    _top_detailLabel.text = _dataSource[@"preferentialDetail"];
    _topTime_detailLabel.text = _dataSource[@"preferentialOverTime"];
    _desription_detailLabel.text = _dataSource[@"discription"];
    _goodsAddress_detail.text = _dataSource[@"address"];
    _merchantName.text = _dataSource[@"merchantAddress"];
    _merchnatAddress.text = _dataSource[@"factoryAddress"];
    _merchanr.text = _dataSource[@"factoryDiscription"];
    
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
