//
//  DetailClassVC.h
//  TPLifeLnsurance
//
//  Created by Magic Johnson on 2/6/15.
//  Copyright (c) 2015 Yangxiaofen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackViewController.h"

@interface DetailClassVC : BackViewController
@property (nonatomic,strong)NSMutableDictionary * classDataSource;
@property (nonatomic,strong)NSString * displayName;
@property (nonatomic,strong)NSString * classname;

@end
