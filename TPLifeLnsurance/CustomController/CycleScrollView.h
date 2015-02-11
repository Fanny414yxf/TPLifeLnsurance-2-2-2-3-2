//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MIN_INTERVAL   0.9   //setAutoScorllingTimeInteval interval 小于此时间,则不再滚动


@protocol CycleScrollViewDelegate;
@protocol CycleScrollViewDatasource;
/**
 *  类似tableView 即时生成.(不重用,也即每个页面可以不一样)
 */
@interface CycleScrollView : UIView
@property (nonatomic, assign) id<CycleScrollViewDatasource, CycleScrollViewDelegate> allDelegate;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
/**
 *  初始化
 *  @prama frame  位置大小
 *  @prama datasourseAndDelegate 设置代理(datasourse 和 delegate)
 */
- (id)initWithFrame:(CGRect)frame withDatasourseAndDelegate:(id)datasourseAndDelegate;
/**
 *  刷新数据
 */
- (void)reloadData;
/**
 *  替换某个位置的视图
 *  @prama view 替换的视图
 *  @prama index 替换的下标
 */
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
/**
 *  设置自动滚动的时间间隔
 *  @prama interval 时间间隔
 */
- (void)setAutoScorllingTimeInteval:(NSTimeInterval)interval;
/**
 *  开始/暂停
 */
- (void)pause:(BOOL)pause;
/**
 *  销毁timer并且把本身移除掉
 */
- (void)invalidate;
@end

@protocol CycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(CycleScrollView *)csView atIndex:(NSInteger)index;
@end

@protocol CycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end
