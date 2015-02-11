//
//  ShopViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "ShopViewController.h"
#import "RecommendMerchantCollectionViewCell.h"
#import "RecommendGoodsCollectionViewCell.h"
#import "ClassificationCollectionViewCell.h"
#import "HeaderViewCollectionReusableView.h"
#import "ScrollView.h"
#import "MerchantDetailVC.h"
#import "DetailClassVC.h"
#import "GoodsDetailVC.h"


@interface ShopViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
{
    NSMutableArray * _imageNames;
    NSMutableArray * _homeImageViews;
    NSInteger _currentIndex;
    NSTimer * _timer;
    NSMutableArray * _scrollviewIngaeUrl;
    
    
}

@property (nonatomic,strong)UISearchBar * searchBar;
@property (nonatomic,strong)ScrollView * advertisementScrollView;
@property(nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)NSMutableDictionary * dataSource;

//@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)NSMutableArray * imageVie;//数组名
@property (nonatomic,strong)NSMutableArray * imageNameArray;//图片名



@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT);
    self.view.backgroundColor = [UIColor orangeColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self refreshWithRequest];
    [self initData];

    [self initailzeUserInterface];
}

- (void)initData
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(processTime) userInfo:nil repeats:YES];
    _imageNames = [[NSMutableArray alloc]init];
    _homeImageViews = [[NSMutableArray  alloc] init];
    _scrollviewIngaeUrl = [[NSMutableArray alloc] init];
    _dataSource = [[NSMutableDictionary alloc] init];
}

- (void)initTimer
{
    _timer.fireDate = [NSDate distantFuture];
}


- (void)initailzeUserInterface
{
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView * titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(70, 30, 80, 25)];
    titleImage.image = IMAGE_WITH_NAME(@"中国太平.png");
    [self.navc addSubview:titleImage];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(170, 30, 200, 30)];
    _searchBar.clipsToBounds = YES;
    _searchBar.text = @"输入商品名称收索";
    _searchBar.layer.cornerRadius = 5;
    [self.view addSubview:_searchBar];
    
    [self.contentView addSubview:self.collectionView];
    
     _advertisementScrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
 
    
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
        flowLayout.minimumLineSpacing
        = 100;
        flowLayout.minimumInteritemSpacing = 10;
        [self.contentView layoutIfNeeded];
        
        CGRect rect  = self.contentView.bounds;
        CGFloat height = self.contentView.bounds.size.height -45;
        rect.size.height = height;
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[RecommendMerchantCollectionViewCell class] forCellWithReuseIdentifier:@"recommendMerchantCollectionViewCell"];
        [_collectionView registerClass:[RecommendGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"recommendGoodsCollectionViewCell"];
        [_collectionView registerClass:[ClassificationCollectionViewCell class] forCellWithReuseIdentifier:@"classificationCollectionViewCell"];
        
        [_collectionView registerClass:[HeaderViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"scrollview"];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
/*
 *设定页眉的尺寸
 *返回头headerView的大小,根据滚动方向不同，header和footer的width和height中只有一个会起作用
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGSize size = {0,200};
        return size;
    }else{
        CGSize size = {0,50};
        return  size;
    }
}

//定义某个Cell的尺寸,可以单独控制item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if (indexPath.section<3) {
        size = CGSizeMake(105, 110);
    }
    else{
        size = CGSizeMake(160, 100);
    }
    return size;
}
//设定全局的行间距，如果想要设定指定区内Cell的最小行距，可以使用下面方法：
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section<3) {
        return 10;
    }
    return 10;
}
//同一行的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 19;
}
//设定全局的区内边距，如果想要设定指定区的内边距，可以使用下面方法：
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 10, 5, 10);
    return edgeInsets;
    
}


#pragma mark - <UICollectionViewDataSource>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"scrollview" forIndexPath:indexPath];
    
        [reusableView addSubview: _advertisementScrollView];
        
        
        reusableView.backgroundColor = [UIColor redColor];
        return  reusableView;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderViewCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleHeader" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            headerView.title.text = @"推荐商户";
        }else if (indexPath.section == 2){
            headerView.title.text = @"推荐商品";
        }else{
            headerView.title.text = @"商品分类";
        }
        return headerView;
    }
    return nil;
    
}
//每个section中有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 0;
    }else if (section >0 && section < 3){
        return 3;
    }
    return 6;
}

//配置重用的item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString * indetifier = @"recommendMerchantCollectionViewCell";
        RecommendMerchantCollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:indetifier forIndexPath:indexPath];
        [cell setcontentItemWithInfo:[ModelData shearInstance].tfactoryList[indexPath.row]];
        return cell;
        
    }else if (indexPath.section == 2){
        static NSString * indetifier = @"recommendGoodsCollectionViewCell";
        RecommendGoodsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:indetifier forIndexPath:indexPath];
        [cell setItemContentWithInfo:[ModelData shearInstance].tgoodsList[indexPath.row]];
        cell.userInteractionEnabled = YES;
//        cell.backgroundColor = [UIColor redColor];
        return cell;
        
    }else if (indexPath.section == 3){
        static NSString * classIndetifier = @"classificationCollectionViewCell";
        ClassificationCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:classIndetifier forIndexPath:indexPath];
        [cell setClassItemContentWithInfo:[ModelData shearInstance].tcateList[indexPath.row]];
        return cell;
    }
    return nil;
}
//有多少个section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}


//选中之后触发事件

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld  %ld",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.section == 1) {
        MerchantDetailVC * merchantDetailVC = [[MerchantDetailVC alloc] init];
        merchantDetailVC.merchantId = _dataSource[@"tfactoryList"][indexPath.row][@"Id"];
        NSLog(@"%@",[ModelData shearInstance].tfactoryList[indexPath.row][@"Id"]);
        [self.navigationController pushViewController:merchantDetailVC animated:YES];

    }else if (indexPath.section == 2)
    {
        GoodsDetailVC * goodsDetailVC  = [[GoodsDetailVC alloc] init];
        goodsDetailVC.goodsId = _dataSource[@"tgoodsList"][indexPath.row][@"Id"];
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
        
    }else if (indexPath.section == 3)
    {
        DetailClassVC * detailClassVC  = [[DetailClassVC alloc] init];
        detailClassVC.displayName = _dataSource[@"tcateList"][indexPath.row][@"Id"];
        detailClassVC.classname = _dataSource[@"tcateList"][indexPath.row][@"displayName"];
        [self.navigationController pushViewController:detailClassVC animated:YES];
        
    }
    
}



#pragma mark - <UISearchBarDelegate>
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}



- (void)processTime
{
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 0) animated:YES];
    
}


#pragma mark - 未登录网络请求
- (void)refreshWithRequest
{

    [NetWork sendShopViewRequestWithTokencallback:^(id result) {
        
        [ModelData shearInstance].token = @"";
        [ModelData shearInstance].tgoodsList = result[@"data"][@"tgoodsList"];
        [ModelData shearInstance].tadverList = result[@"data"][@"tadverList"];
        [ModelData shearInstance].tcateList = result[@"data"][@"tcateList"];
        [ModelData shearInstance].tfactoryList = result[@"data"][@"tfactoryList"];
        _dataSource = result[@"data"];
        NSLog(@"商品%@",result);
        
        NSMutableArray * imageName = [[NSMutableArray alloc] init];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        for (int i  = 0; i < 4; i ++) {
            [imageName addObject:[NSString stringWithFormat:@"http://192.168.7.56:8090/tpl%@",result[@"data"][@"tadverList"][i][@"pictureUrl"]]];
        }
        
        [dic setObject:imageName forKey:@"image"];
        
        [_advertisementScrollView setScrollViewInfo:dic];

    }];
}

#pragma mark - 登录网络请求
- (void)viewWillAppear:(BOOL)animated
{
    if ([LoginInforCenter shearLoginInformation].isLogin) {
        [NetWork sendShopViewRequestWithToken:[ModelData shearInstance].token callback:^(id result) {
            [ModelData shearInstance].token = @"";
            [ModelData shearInstance].tgoodsList = result[@"data"][@"tgoodsList"];
            [ModelData shearInstance].tadverList = result[@"data"][@"tadverList"];
            [ModelData shearInstance].tcateList = result[@"data"][@"tcateList"];
            [ModelData shearInstance].tfactoryList = result[@"data"][@"tfactoryList"];
            
            NSMutableArray * imageName = [[NSMutableArray alloc] init];
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            for (int i  = 0; i < 4; i ++) {
                [imageName addObject:[NSString stringWithFormat:@"http://192.168.7.56:8090/tpl%@",result[@"data"][@"tadverList"][i][@"pictureUrl"]]];
                
            }
            
            [dic setObject:imageName forKey:@"image"];
            [_advertisementScrollView setScrollViewInfo:dic];
        }];
    }
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
