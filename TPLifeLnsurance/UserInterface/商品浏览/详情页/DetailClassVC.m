//
//  DetailClassVC.m
//  TPLifeLnsurance
//
//  Created by Magic Johnson on 2/6/15.
//  Copyright (c) 2015 Yangxiaofen. All rights reserved.
//

#import "DetailClassVC.h"
#import "DetailClassTableViewCell.h"
#import "DescriptionView.h"

@interface DetailClassVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIButton * mentButton;
@property (nonatomic,strong)UITableView * goodsList;
@property (nonatomic,strong)UITextField * searchTextField;
@property (nonatomic,strong)UIView  * rightView;
@property (nonatomic,strong)UIView * contentView;
@property (nonatomic,strong)UIImageView * searchView;



@end

@implementation DetailClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self userInterface];
    [self upClassDetailWithRequest];
}

- (void)userInterface
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@",self.classname];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.backButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVC_HIGTH, SCREEN_WIDTH, SCREEN_HEIGHT - NAVC_HIGTH - TAB_BAR_HEIGHT)];
    [self.view addSubview:_contentView];
    _mentButton  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 20, 40, 40)];
    [_mentButton setImage:[UIImage imageNamed:@"菜单.png"] forState:UIControlStateNormal];
    [_mentButton addTarget:self action:@selector(processMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mentButton];
    
    _searchView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 300, 40)];
    _searchView.image = IMAGE_WITH_NAME(@"分类详情收索.png");
    [_contentView addSubview:_searchView];

    
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 64, 120, SCREEN_HEIGHT - NAVC_HIGTH - TAB_BAR_HEIGHT)];
    _rightView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"菜单背景.png"]];
    [self.view addSubview:_rightView];
    
    
    _goodsList = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 550) style:UITableViewStylePlain];
    _goodsList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _goodsList.delegate = self;
    _goodsList.dataSource = self;
    [_goodsList registerClass:[DetailClassTableViewCell class] forCellReuseIdentifier:@"classcell"];
    [_contentView addSubview:_goodsList];
    
        
    
//    NSArray * buttonImage = @[@"分类占位符.png"];
    NSArray * buttonTitle = @[@"所有商品",@"电子设备",@"电影",@"旅游",@"化妆护肤"];
    for (int i = 0; i < 5; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0 + i * (SCREEN_HEIGHT - NAVC_HIGTH - TAB_BAR_HEIGHT)/5 , 120, (SCREEN_WIDTH - NAVC_HIGTH - TAB_BAR_HEIGHT)/5)];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(processButton) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
//            [button setImage:[UIImage imageNamed:@"分类占位符.png"] forState:UIControlStateNormal];
        }
        [_rightView addSubview:button];
    }
    

}


- (void)processMenuButton:(UIButton *)sender
{
        [UIView animateWithDuration:0.3 animations:^{
            _contentView .frame = CGRectMake(_contentView.frame.origin.x == -120 ? 0 : - 120, NAVC_HIGTH, SCREEN_WIDTH, SCREEN_HEIGHT - NAVC_HIGTH-TAB_BAR_HEIGHT);
            _rightView.frame = CGRectMake(_rightView.frame.origin.x == SCREEN_WIDTH ? SCREEN_WIDTH - 120 : SCREEN_WIDTH, NAVC_HIGTH, 120, SCREEN_HEIGHT  - NAVC_HIGTH - TAB_BAR_HEIGHT);
            
        }];

}

- (void)processButton
{
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    DetailClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"classcell"];
        [cell setCellContentWithInfo:_classDataSource[@"dataList"][indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}





- (void)upClassDetailWithRequest
{
    [NetWork sendClassInfomationListRequestWithPageSize:5 currentPage:1 categoryld:self.displayName token:@"" callback:^(id result) {
        NSLog(@"商品种类详情%@",result);
        
        _classDataSource = [[NSMutableDictionary alloc] init];
        _classDataSource = result[@"data"];
        
        [_goodsList reloadData];
        
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
