//
//  TabarView.h
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TabBarViewDelegate <NSObject>

- (void)tabBarDidSelectedWithIndex:(NSInteger)selectedIndex;


@end

@interface TabarView : UIView

@property(nonatomic,assign) id <TabBarViewDelegate> delegate;//assign不持有


@end
