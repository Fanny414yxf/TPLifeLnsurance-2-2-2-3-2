//
//  BookingViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "BookingViewController.h"
#import "BookingTableViewCell.h"
#import "BookingDetailVCViewController.h"

@interface BookingViewController ()  <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * bookingTableView;

@property (nonatomic,strong)NSMutableArray * ordersDatas;
@property (nonatomic,strong)UITextField * searchTextField;
@property (nonatomic,strong)UISegmentedControl * segMentedControl;
@property (nonatomic,strong)NSString* type;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.contentView.backgroundColor = COLOR(236, 236, 236, 1);

    [self initailzeInterface];
    [self upBookingDataRequest];

}


- (void)initailzeInterface
{
    UIImageView * searchView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 140, 330, 40)];
    searchView.userInteractionEnabled = YES;
    searchView.image = IMAGE_WITH_NAME(@"收索.png");
    [self.view addSubview:searchView];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 300, 40)];
    _searchTextField.textColor = [UIColor blackColor];
    [searchView addSubview:_searchTextField];

    
    NSArray * butTitle = @[@"待处理",@"已处理",@"已完成",@"已取消",@"全部订单"];
//    _segMentedControl.frame = CGRectMake(300, 330, 300, 40);
//    _segMentedControl.center = CGPointMake(220, 90);
//    _segMentedControl = [[UISegmentedControl alloc] initWithItems:butTitle];
//    _segMentedControl.layer.borderWidth = 1;
//    _segMentedControl.selectedSegmentIndex = 4;
//    _segMentedControl.layer.borderColor = [[UIColor blueColor]CGColor];
//    [_segMentedControl addTarget:self action:@selector(processSegmentControl:) forControlEvents:UIControlEventValueChanged];
//    [self.contentView addSubview:_segMentedControl];
    

    for (int i = 0; i < 5; i ++) {
        UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(20 + i * SCREEN_WIDTH/5.5, 80, SCREEN_WIDTH/5.5, 40)];
        button.layer.borderColor = [[UIColor blueColor]CGColor];
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:butTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(processButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (i == 4) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor blueColor];
        }

    }
    
    _ordersDatas = [[NSMutableArray alloc] init];
    
    UILabel * titlieLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 100, 25)];
    titlieLabel.text = @"我的订单";
    titlieLabel.textColor = [UIColor whiteColor];
    titlieLabel.font = FONT(23);
    [self.navc addSubview:titlieLabel];
    
    _bookingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH,SCREEN_HEIGHT - NAVC_HIGTH - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _bookingTableView.backgroundColor = [UIColor yellowColor];
    _bookingTableView.delegate = self ;
    _bookingTableView.dataSource = self;
    [_bookingTableView registerClass:[BookingTableViewCell class] forCellReuseIdentifier:@"bookingCell"];
    [self.view addSubview:_bookingTableView];
    
}


#pragma  mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ordersDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bookingCell"];
    [cell  setBookingCellContentWithInfo:_ordersDatas[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 290;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BookingDetailVCViewController * bookingDetailVC =  [[BookingDetailVCViewController alloc] init];
    bookingDetailVC.orderId = _ordersDatas[indexPath.row][@"orderId"];
    [self.navigationController pushViewController:bookingDetailVC animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TAB_BAR_HIDDEN object:self];
    

}


- (void)processSegmentControl:(UISegmentedControl *)sender
{
    NSInteger  index = sender.selectedSegmentIndex;
    if (index != 4) {
        _type = [NSString stringWithFormat:@"%ld",index + 1];
    }else{
        _type = @"";
    }
    
    [self upBookingDataRequest];
}


- (void)processButton
{
    
    
    
}


#pragma mark - 网络请求
- (void)upBookingDataRequest
{
    [NetWork sendAllBookingRequestWithUserid:[ModelData shearInstance].userId token:[ModelData shearInstance].token userType:1 pageSize:2 pageNo:1 callback:^(id result) {
        NSLog(@"全部订单%@",result);
        
        _ordersDatas = result[@"data"][@"orders"];
        [_bookingTableView reloadData];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
