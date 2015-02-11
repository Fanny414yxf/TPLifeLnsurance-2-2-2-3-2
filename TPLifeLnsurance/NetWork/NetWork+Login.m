//
//  NetWork+Login.m
//  网络请求1
//
//  Created by rimi on 15-1-21.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "NetWork+Login.h"
#import "NetWork.h"
//登录
#define LOGIN_URL @"http://192.168.7.56:8090/tpl/api/loginApi/login"
#define REGISTRATION_ONE_URL @"http://192.168.7.56:8090/tpl/api/loginApi/register1"
#define REGISTRATION_TOW_URL @"http://192.168.7.56:8090/tpl/api/loginApi/register2"
#define EXIT_URL @"http://192.168.7.56:8090/tpl/api/loginApi/loginOut"


//个人中心
#define GETAPPUSERINFO_URL @"http://192.168.7.56:8090/tpl/api/setting/getAppUserInfo"
#define EDIT_APPUSER_URL @"http://192.168.7.56:8090/tpl/api/setting/editAppUser"
#define EDIT_PASSWORD_URL @"http://192.168.7.56:8090/tpl/api/setting/editPassword"



//商品
#define GOODSHOMELIST_URL @"http://192.168.7.56:8090/tpl/api/goods/getGoodsHomeListApi"
#define MERCHANT_DETAIL @"http://192.168.7.56:8090/tpl/api/factoryInfo/getFactoryInfo.do"
#define GOODS_DETAIL @"http://192.168.7.56:8090/tpl/api/goods/getGoodsInfoApi"
#define CLASS_DATAIL @"http://192.168.7.56:8090/tpl/api/goods/getGoodsListByCategoryApi"

//消息

#define MESSAGE_LIST @"http://192.168.7.56:8090/tpl/api/platMessageApi/getMessageListByUserId"
#define MESSAGE_DETAIL @"http://192.168.7.56:8090/tpl/api/platMessageApi/getMessageListByMsgId"
#define SENDER_MESSAGE_URL @"http://192.168.7.56:8090/tpl/api/platMessageApi/sendMessage"


//订单
#define GETORDERS @"http://192.168.7.56:8090/tpl/api/order/getOrders"
#define GETORDER_DETAIL @"http://192.168.7.56:8090/tpl/api/order/getOrder"


@implementation NetWork (Login)


#pragma mark ---- 登录
/**登录请求*/
+ (void)sendLoginRequestWithUserName:(NSString *)userName passWord:(NSString*)passWord callback:(Callback)callback
{
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userName forKey:@"username"];
    [parameters setObject:passWord forKey:@"password"];
    
    [parameters setObject:@"1232322323" forKey:@"deviceId"];
    [parameters setObject:@"1" forKey:@"deviceType"];
    [parameters setObject:@"" forKey:@"deviceName"];
    
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:LOGIN_URL parameters:afParams callback:callback];
    //参数不能变callback

}

/***退出请求*/
+ (void)sendExitRuquestWithUserId:(NSString *)string CallBack:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"1232322323" forKey:@"userId"];
    [parameters setObject:@"1" forKey:@"deviceType"];
    [parameters setObject:@"1232322323" forKey:@"deviceId"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:EXIT_URL parameters:afParams callback:callback];
    //参数不能变callback
 
}


/**
 *  注册第一步
 */
+ (void)sendRegister1WithRequestWithCredentialsNo:(NSString *)number  credentialsType:(NSString *)type name:(NSString *)name Callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:number forKey:@"credentialsNo"];
    [parameters setObject:type forKey:@"credentialsType"];
    [parameters setObject:name forKey:@"agentName"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:REGISTRATION_ONE_URL parameters:afParams callback:callback];
 
}


/**
 *  获取个人信息getAppUserInfo
 */
+ (void)sendRequesrToGetAppUserInfoWithUserid:(NSString *)userid token:(NSString *)token callback:(Callback)callback
{
   
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:token forKey:@"token"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:GETAPPUSERINFO_URL parameters:afParams callback:callback];

}

/**
 *  修改个人信editAppUser
 */
+ (void)sendRequewrtForEditAppUserWithUserid:(NSString *)userid token:(NSString *)token telephone:(NSString *)telephone callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:telephone forKey:@"telephone"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:EDIT_APPUSER_URL parameters:afParams callback:callback];

}


/**
 *  修改密码editPassword
 */
+ (void)sendRequewrtForEditAppUserWithUserid:(NSString *)userid token:(NSString *)token passWord:(NSString *)passWord callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:passWord forKey:@"password"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:EDIT_PASSWORD_URL parameters:afParams callback:callback];
    
}

/**
 *  登录首页展示（广告位、商品、商品种类）
 */
+ (void)sendShopViewRequestWithToken:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:token forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:GOODSHOMELIST_URL parameters:afParams callback:callback];

}

/**
 *  未登录首页展示
 *
 *
 */
+ (void)sendShopViewRequestWithTokencallback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"" forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:GOODSHOMELIST_URL parameters:afParams callback:callback];
    
}


/**
 *  获取商家信息列表
 */

+ (void)sendMerchantDatailRequestWithMerchantId:(NSString *)merchantid pageSize:(NSInteger)pageSize token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:merchantid forKey:@"id"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pageSize"];
    [parameters setObject:token forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:MERCHANT_DETAIL parameters:afParams callback:callback];

}

/**
 *
 *
 *  获取商品信息详情（根据商品id
 */
+ (void)sendGoodsDetailRequestWithGoodid:(NSString *)goodid token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:goodid forKey:@"goodsId"];
    [parameters setObject:token forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:GOODS_DETAIL parameters:afParams callback:callback];

}


/**
 *  根据商品种类获取商品信息列表
 */

+ (void)sendClassInfomationListRequestWithPageSize:(NSInteger)pagesize currentPage:(NSInteger)currentpage categoryld:(NSString *)categoryid token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%ld",pagesize] forKey:@"pageSize"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)currentpage] forKey:@"currentPage"];
    [parameters setObject:categoryid forKey:@"categoryId"];
    [parameters setObject:token forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:CLASS_DATAIL parameters:afParams callback:callback];

}

/**
 *  消息列表
 */
+ (void)sendGetMessageListRequestByUserid:(NSString *)userId currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userId forKey:@"userId"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)currentPage] forKey:@"currentPage"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pageSize"];
    [parameters setObject:token forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:MESSAGE_LIST parameters:afParams callback:callback];

}

/**
 *  消息详情页
 */
+ (void)sendGetMessageListRequestByUserdi:(NSString *)userid messageid:(NSString *)messageid token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:messageid forKey:@"messageId"];
    [parameters setObject:token forKey:@"token"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:MESSAGE_DETAIL parameters:afParams callback:callback];
    
}

/**
 *  订单
 */
+ (void)sendAllBookingRequestWithUserid:(NSString *)userid token:(NSString *)token userType:(NSInteger)userType pageSize:(NSInteger)pageSize pageNo:(NSInteger)pageNo  callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userid forKey:@"userId"];
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)userType] forKey:@"userType"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pageSize"];

    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"pageNo"];

    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:GETORDERS parameters:afParams callback:callback];
}



/**
 *  获取订单详情getOrder
 */
+ (void)sendAllBookingDetailRequestWithOrderid:(NSString *)orderid userType:(NSInteger)userType token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:orderid forKey:@"orderId"];
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:[NSString stringWithFormat:@"%ld",(long)userType] forKey:@"userType"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:GETORDER_DETAIL parameters:afParams callback:callback];
}

/***
 发送消息
 */
+ (void)senderSendMessageNetWorkingWithUserid:(NSString *)sendMessageId receiveId:(NSString *)receiveId content:(NSString *)contentString token:(NSString *)token callback:(Callback)callback
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:sendMessageId forKey:@"userId"];
    [parameters setObject:receiveId forKey:@"receiverId"];
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:contentString forKey:@"content"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * afParams = [[NSMutableDictionary alloc]initWithCapacity:0];
    [afParams setObject:paramStr forKey:@"paramJson"];
    
    [NetWork sendPostRequestWithURL:SENDER_MESSAGE_URL parameters:afParams callback:callback];

    
}








@end
