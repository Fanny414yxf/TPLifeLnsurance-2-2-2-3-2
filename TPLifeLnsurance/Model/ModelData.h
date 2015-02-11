//
//  ModelData.h
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-2.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelData : NSObject
/**
 *  登录
 */
@property (nonatomic,strong)NSString * userId;       //用户ID
@property (nonatomic,strong)NSString * userName;     //用户名
@property (nonatomic,strong)NSString * token;        //访问令牌(由用户登录名+密码+时间戳组成的字符串的MD5码串
@property (nonatomic,assign)NSInteger * userType;    //用户类型
@property (nonatomic,assign)NSInteger * msgNum;      //未读消息

/**
 *  个人信息
 */
@property (nonatomic,strong)NSArray * agentList;      //代理人集合
@property (nonatomic,strong)NSString * uid;           //用户id
@property (nonatomic,strong)NSString * id_card;       //身份证号
@property (nonatomic,strong)NSString * login_name;    //用户登录名
@property (nonatomic,strong)NSString * name;          //用户真实姓名
@property (nonatomic,strong)NSString * telephone;     //电话号码


/**
 *  商品
 *
 */
//Map1
@property (nonatomic,strong)NSMutableArray * tgoodsList;         //商品记录结果

@property (nonatomic,strong)NSString * tgoodsid;               //商品id
@property (nonatomic,strong)NSString * tgoodsgoodsNo;          //商品编号
@property (nonatomic,strong)NSString * tgoodsdisplayName;      //商品名称
@property (nonatomic,strong)NSString * tgoodscategoryId;       //商品所属种类id
@property (nonatomic,strong)NSString * tgoodsmerchant;         //店主
@property (nonatomic,strong)NSString * tgoodsmerchantTelephone;//店主电话
@property (nonatomic,strong)NSString * tgoodsmerchantAddress;  //店主地址
@property (nonatomic,assign)int * tgoodsnumber;               //商品数量
@property (nonatomic,assign)double * tgoodsmarketPrice;       //商品价格
@property (nonatomic,assign)double * tgoodsplatformPrice;      //平台价格
@property (nonatomic,strong)NSString * tgoodsimgUrl;           //商品图片地址
@property (nonatomic,strong)NSString * tgoodsdiscription;      //商品描述
@property (nonatomic,strong)NSString * tgoodsspecification;    //参数规格
@property (nonatomic,strong)NSString * tgoodscreaterId;        //参数规格
@property (nonatomic,strong)NSData * tgoodscreateTime;       //创建时间
//Map2
@property (nonatomic,strong)NSMutableArray * tadverList;

//Map3
@property (nonatomic,strong)NSMutableArray * tcateList;

//Map4
@property (nonatomic,strong)NSMutableArray * tfactoryList;//商家列表

@property (nonatomic,strong)NSString * tfactoryid;//商家id
@property (nonatomic,strong)NSString * tfactorydisplayName;//商家种类名称
@property (nonatomic,strong)NSString * tfactorydescription;//商家描述
@property (nonatomic,strong)NSString * tfactoryimgUrl;//商家图片地址








+ (ModelData *)shearInstance;


@end
