//
//  MessageDetailTableViewCell.h
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-7.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailTableViewCell : UITableViewCell

- (void)sendMessageDetailContentWinthInfo:(NSDictionary *)info size_x:(NSInteger)size_w size_h:(NSInteger)size_h;
//X系统消息
- (void)setCellSystemMessageDetailContentWithInfo:(NSDictionary *)info size_x:(NSInteger)size_w size_h:(NSInteger)size_h;


@end
