//
//  Header.h
//  TPLifeLnsurance
//
//  Created by rimi on 15-1-31.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#ifndef TPLifeLnsurance_Header_h
#define TPLifeLnsurance_Header_h


#import "ViewController.h"
#import "ModelData.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "LoginInforCenter.h"
#import "NetWork+Login.h"
#import "ShopViewController.h"
#import "MassegeViewController.h"
#import "BookingViewController.h"
#import "BaceViewController.h"
#import "MainViewController.h"



//获取屏幕大小


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PERSONAL_WIDTH SCREEN_WIDTH - 110

//判断当前设备是什么  5 6 6PLUS缩放
#define IPHONE4 SCREEN_HEIGHT == 480
#define IPHONE5 SCREEN_HEIGHT == 568
#define IPHONE6 SCREEN_HEIGHT == 667

//定义比例
#define PROPORTANT SCREEN_WIDTH / 320


//tabBar高度 宽度
#define TAB_BAR_HEIGHT 50
#define NAVC_HIGTH  64

//字体大小
#define FONT(fontSize) [UIFont systemFontOfSize:fontSize]
//颜色
#define COLOR(redColor, greenColor, blueColor, alphaColor)[UIColor colorWithRed:redColor/255.0 green:greenColor/255.0 blue:blueColor/255.0 alpha:alphaColor]


//tag值
#define TAB_BAR_TAG_BASE 1000

//图片的内存常驻
#define IMAGE_WITH_NAME(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:name]];

//通知
#define NOTIFY_SWITCH_TAB_BAR @"NotifyTabBar"
#define NOTIFY_TAB_BAR_HIDDEN @"hidden"
#define NOTIFY_TAB_BAR_SHOW @"show"

#define NOTIFY_LOGIN_INFOR @"personalViewmove"


#define IMAGE_URL(info) [NSString stringWithFormat:@"http://192.168.7.56:8090/tpl%@",info]




#endif
