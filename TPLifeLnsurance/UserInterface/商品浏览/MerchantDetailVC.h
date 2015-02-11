//
//  MerchantDetailVC.h
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-5.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackViewController.h"

@interface MerchantDetailVC : BackViewController


@property (nonatomic,strong)NSMutableDictionary * dataSource;
@property (nonatomic,strong)NSString * merchantId;
@end
