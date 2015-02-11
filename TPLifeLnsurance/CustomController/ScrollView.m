//
//  ScrollView.m
//  TPLifeLnsurance
//
//  Created by Magic Johnson on 2/3/15.
//  Copyright (c) 2015 Yangxiaofen. All rights reserved.
//

#define CUSTOM_IMAGE_WIDTH  CGRectGetWidth(self.bounds)
#define CUSTOM_IMAGE_HEIGHT CGRectGetHeight(self.bounds)

#import "ScrollView.h"

@interface ScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)UIImageView * imageView ;

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)NSMutableArray * imageVie;//数组名
@property (nonatomic,strong)NSMutableArray * imageNameArray;//图片名

@end

@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
       
         [self initUserInterface];
    }
    return self;
}


- (void)initData
{
    _imageVie = [[NSMutableArray alloc] init];
    _imageNameArray = [[NSMutableArray alloc] init];
}


- (void)initUserInterface
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 200);
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    _scrollView.autoresizesSubviews = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //分别创建3个imageView到scrollView上对应的位置
    for (int i = 0 ;i < 3;i ++ ) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, 200)];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [_scrollView addSubview:imageView];
        
        //把着3个imageView加入_showImageArr数组
        [_imageVie addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changecontentOffSet) userInfo:nil repeats:YES];

}

//赋值  刷新
- (void)setScrollViewInfo:(NSMutableDictionary *)info
{
    _imageNameArray = info[@"image"];
   
    [self updataImageView];
    
}


/**
 *  更新三张imageView对应的图片
 */
- (void)updataImageView
{
    int i = 0;
    //遍历_showImageArr里的imageView分别给予对应的图片
    for (UIImageView * imageView in _imageVie) {
            imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageNameArray[i]]]];
        i ++;
    }
}

#pragma mark - <UIScrollerView>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        if (scrollView.contentOffset.x >= SCREEN_WIDTH * 2) {
            if (_imageNameArray.count>0) {
                NSString * firstImageName = _imageNameArray[0];
                [_imageNameArray removeObjectAtIndex:0];
                [_imageNameArray addObject:firstImageName];
            }
            
        }else if (scrollView.contentOffset.x <= 0){
            
            if (_imageNameArray.count != 0) {
                NSString * lastImageName = _imageNameArray.lastObject;
                [_imageNameArray removeLastObject];
                [_imageNameArray insertObject:lastImageName atIndex:0];

            }
            
        }else{
            return;
        }
        
        [self updataImageView];
        scrollView.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
    
}
//改变偏移量
- (void)changecontentOffSet
{
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
}











/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
