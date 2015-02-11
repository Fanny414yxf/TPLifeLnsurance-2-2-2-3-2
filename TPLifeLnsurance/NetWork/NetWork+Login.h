//
//  NetWork+Login.h
//  网络请求1
//
//  Created by rimi on 15-1-21.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "NetWork.h"

@interface NetWork (Login)
/**登录请求*/
+ (void)sendLoginRequestWithUserName:(NSString *)userName passWord:(NSString*)passWord callback:(Callback)callback;

/***退出请求*/
+ (void)sendExitRuquestWithUserId:(NSString *)string CallBack:(Callback)callback;


/**
 *  注册第一步
 */
+ (void)sendRegister1WithRequestWithCredentialsNo:(NSString *)number  credentialsType:(NSString *)type name:(NSString *)name Callback:(Callback)callback;

/**
 *  获取个人信息getAppUserInfo
 */
+ (void)sendRequesrToGetAppUserInfoWithUserid:(NSString *)userid token:(NSString *)token callback:(Callback)callback;


/**
 *  修改个人信editAppUser
 */
+ (void)sendRequewrtForEditAppUserWithUserid:(NSString *)userid token:(NSString *)token telephone:(NSString *)telephone callback:(Callback)callback;

/**
 *  修改密码editPassword
 */
+ (void)sendRequewrtForEditAppUserWithUserid:(NSString *)userid token:(NSString *)token passWord:(NSString *)passWord callback:(Callback)callback;



/**
 *  登录首页展示（广告位、商品、商品种类）
 */
+ (void)sendShopViewRequestWithToken:(NSString *)token callback:(Callback)callback;

/**
 *  未登录首页展示
 *
 *
 */
+ (void)sendShopViewRequestWithTokencallback:(Callback)callback;


/**
 *  获取商家信息列表 根据商家id）
 */
+ (void)sendMerchantDatailRequestWithMerchantId:(NSString *)merchantid pageSize:(NSInteger)pageSize token:(NSString *)token callback:(Callback)callback;

/**
 *
 *
 *  获取商品信息详情（根据商品id
 */
+ (void)sendGoodsDetailRequestWithGoodid:(NSString *)goodid token:(NSString *)token callback:(Callback)callback;

/**
 *  根据商品种类获取商品信息列表
 */

+ (void)sendClassInfomationListRequestWithPageSize:(NSInteger)pagesize currentPage:(NSInteger)currentpage categoryld:(NSString *)categoryid token:(NSString *)token callback:(Callback)callback;

/**
 *  消息列表
 */
+ (void)sendGetMessageListRequestByUserid:(NSString *)userId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize token:(NSString *)token callback:(Callback)callback;

/**
 *  消息详情页
 */
+ (void)sendGetMessageListRequestByUserdi:(NSString *)userid messageid:(NSString *)messageid token:(NSString *)token callback:(Callback)callback;

/**
 *  订单
 */
//+ (void)sendAllBookingRequestWithUserid:(NSString *)userid token:(NSString *)token userType:(NSInteger)userType pageSize:(NSInteger)pageSize pageNo:(NSInteger)pageNo status:(NSString *)status callback:(Callback)callback;
+ (void)sendAllBookingRequestWithUserid:(NSString *)userid token:(NSString *)token userType:(NSInteger)userType pageSize:(NSInteger)pageSize pageNo:(NSInteger)pageNo callback:(Callback)callback;


/**
 *  获取订单详情getOrder
 */
+ (void)sendAllBookingDetailRequestWithOrderid:(NSString *)orderid userType:(NSInteger)userType token:(NSString *)token callback:(Callback)callback;

/***
 发送消息
 */
+ (void)senderSendMessageNetWorkingWithUserid:(NSString *)sendMessageId receiveId:(NSString *)receiveId content:(NSString *)contentString token:(NSString *)token callback:(Callback)callback;



@end
