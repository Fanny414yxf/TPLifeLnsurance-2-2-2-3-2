//
//  MessageDetailVC.h
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-7.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackViewController.h"

@interface MessageDetailVC : BackViewController

@property (nonatomic,strong)NSString * messageId;
@property (nonatomic,strong)NSString * receiverName;

@end
