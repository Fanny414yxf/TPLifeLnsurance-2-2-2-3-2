//
//  MerchantDetailVC.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-5.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "MerchantDetailVC.h"
#import "ScrollView.h"
#import "DescriptionView.h"

@interface MerchantDetailVC ()<UIScrollViewDelegate>

@property (nonatomic,strong)ScrollView * photoScrollView;
@property (nonatomic,strong)UIScrollView * detailScrollView;
@property (nonatomic,strong)NSMutableArray * descreption;
@property (nonatomic,strong)DescriptionView * descrition;
@property (nonatomic,strong)NSArray * info;

@property (nonatomic,strong)UIImageView * photoImage;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * priceVIP;



@end

@implementation MerchantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"商户详情";
    [self.backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [self UPMerchantDetailDataRequest];
    [self userInterface];
    
    
    
}
- (void)userInterface
{
   
    
    self.titleLabel.text = @"商家详情";
    
    _dataSource = [[NSMutableDictionary alloc] init];
    
    
    _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVC_HIGTH, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _detailScrollView.showsVerticalScrollIndicator = YES;
    _detailScrollView.showsHorizontalScrollIndicator = YES;
//    _detailScrollView.backgroundColor = [UIColor cyanColor];
    _detailScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    _detailScrollView.delegate = self;
    
    [self.view addSubview:_detailScrollView];
    
    _photoScrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _photoScrollView.backgroundColor = [UIColor grayColor];
    [_detailScrollView addSubview:_photoScrollView];
    
    
   
    
    _descrition = [[DescriptionView alloc] initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH - 20, 700)];
    _descrition.layer.borderColor = [[UIColor clearColor]CGColor];
    _descrition.layer.borderWidth = 1;
    _descrition.layer.borderColor = [[UIColor grayColor]CGColor];
    _descrition.layer.cornerRadius = 5;
//    _descrition.backgroundColor = [UIColor cyanColor];
    [_detailScrollView addSubview:_descrition];
    
    
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_detailScrollView.bounds) + 300, SCREEN_WIDTH, 150)];
//    footView.backgroundColor = [UIColor yellowColor];
    [_detailScrollView addSubview:footView];
    
    _photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    _photoImage.backgroundColor = [UIColor greenColor];
    _photoImage.layer.cornerRadius = 5;
    _photoImage.layer.cornerRadius = 5;
    _photoImage.clipsToBounds = YES;
    [footView addSubview:_photoImage];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100, 30)];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = FONT(22);
    [footView addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 65, 100, 20)];
    _priceLabel.textColor = [UIColor grayColor];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = FONT(16);
    [footView addSubview:_priceLabel];
    
    _priceVIP = [[UILabel alloc] initWithFrame:CGRectMake(150, 90, 100, 20)];
    _priceVIP.textColor = [UIColor grayColor];
    _priceVIP.textAlignment = NSTextAlignmentLeft;
    _priceVIP.font = FONT(16);
    [footView addSubview:_priceVIP];

    
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [self UPMerchantDetailDataRequest];
}
- (void)UPMerchantDetailDataRequest
{
    [NetWork sendMerchantDatailRequestWithMerchantId:self.merchantId pageSize:1 token:@"" callback:^(id result) {
        NSLog(@"商家详情页%@",result);
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
       
         _info = @[_dataSource[@"displayName"],_dataSource[@"address"],_dataSource[@"discription"],_dataSource[@"perPay"],_dataSource[@"serviceName"],_dataSource[@"parking"]];
        
        [_descrition setDetailInformation:_info];
        
        
        _photoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:IMAGE_URL(result[@"data"][@"goodsData"][@"dataList"][0][@"imgUrl"])]]];
        _nameLabel.text = result[@"data"][@"goodsData"][@"dataList"][0][@"displayName"];
        _priceLabel.text = [NSString stringWithFormat:@"市场价:%@",result[@"data"][@"goodsData"][@"dataList"][0][@"marketPrice"]];
        
        NSLog(@"%@",_priceLabel.text);
        

        
    }];
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
