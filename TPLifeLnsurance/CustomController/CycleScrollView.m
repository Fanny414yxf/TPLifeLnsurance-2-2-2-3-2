//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "CycleScrollView.h"

@interface CycleScrollView ()<UIScrollViewDelegate>
{
    __weak id<CycleScrollViewDatasource> _datasource;
    __weak id<CycleScrollViewDelegate> _delegate;
    NSInteger _totalPages;
    NSInteger _currentPage;
    NSMutableArray *_arrayWithViews;
    NSTimeInterval _interval;
    BOOL _isMax;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CycleScrollView

- (id)initWithFrame:(CGRect)frame withDatasourseAndDelegate:(id)datasourseAndDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        _datasource = datasourseAndDelegate;
        _delegate = datasourseAndDelegate;
        _currentPage = 0;
        
         [self reloadData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        _currentPage = 0;
    }
    return self;
}

#pragma mark - getMethods
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
    }
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    return _scrollView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

#pragma mark - SetMethods
- (void)setAllDelegate:(id<CycleScrollViewDatasource, CycleScrollViewDelegate>)allDelegate
{
    _allDelegate = allDelegate;
    _delegate = allDelegate;
    _datasource = allDelegate;
    [self reloadData];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor ?: [UIColor whiteColor];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor ?: [UIColor lightGrayColor];
}

#pragma mark  - Methods
- (void)invalidate
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    [self removeFromSuperview];
    self.timer = nil;
}
- (void)pause:(BOOL)pause;
{
    if (pause) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }else {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_interval]];
    }
}
- (void)setAutoScorllingTimeInteval:(NSTimeInterval)interval;
{
    if (interval < MIN_INTERVAL || _totalPages <= 1) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(autoScrolling) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    _interval = interval;
}
- (void)autoScrolling
{
    if (_currentPage < _totalPages - 1  && !_isMax) {
        _currentPage = [self validPageValue:_currentPage + 1];
        _isMax = _currentPage == _totalPages - 1 ? YES : NO;
    }else if (_currentPage == 0 && _isMax) {
        _currentPage = [self validPageValue:_currentPage + 1];
        _isMax = _currentPage == _totalPages - 1 ? YES : NO;
    }else {
        _currentPage = [self validPageValue:_currentPage - 1];
        _isMax = _currentPage == 0 ? NO : YES;
    }
    [self loadData];
}
- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    self.pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    self.pageControl.currentPage = _currentPage;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_currentPage];
    
    for (int i = 0; i < 3; i++) {
        UIView *v = [_arrayWithViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [self.scrollView addSubview:v];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page {
    
    NSInteger pre = [self validPageValue:_currentPage - 1];
    NSInteger last = [self validPageValue:_currentPage + 1];
    
    _arrayWithViews = _arrayWithViews ?: [[NSMutableArray alloc] init];
    [_arrayWithViews removeAllObjects];
    
    UIView *viewPre = [_datasource pageAtIndex:pre];
    UIView *viewpage = [_datasource pageAtIndex:page];
    UIView *viewLast = [_datasource pageAtIndex:last];
    
    [viewPre setUserInteractionEnabled:YES];
    [viewpage setUserInteractionEnabled:YES];
    [viewLast setUserInteractionEnabled:YES];
    
    [_arrayWithViews addObject:viewPre];
    [_arrayWithViews addObject:viewpage];
    [_arrayWithViews addObject:viewLast];
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;

    return value;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_currentPage];
    }
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _currentPage) {
        [_arrayWithViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_arrayWithViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [self.scrollView addSubview:v];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    if (_totalPages == 0) {
        return;
    }
    int x = aScrollView.contentOffset.x;
    //往下翻一张
    if(x >= (2 * self.frame.size.width)) {
        _currentPage = [self validPageValue:_currentPage + 1];
        _isMax = NO;
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _currentPage = [self validPageValue:_currentPage - 1];
        _isMax = YES;
        [self loadData];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self pause:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
    [self pause:NO];
}

@end
