//
//  NetWork.m
//  网络请求1
//
//  Created by rimi on 15-1-21.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"

@implementation NetWork

+ (void)sendPostRequestWithURL:(NSString *)url parameters:(NSDictionary *)parmeters callback:(Callback)callback
{
    //初始化
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //设置响应类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",nil];//text/html  JSON解析
    //请求类型
    [manager POST:url parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功回调
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败回调
        //不做操作 或 返回错误  或 弹框
        
        if (callback) {
            callback(nil);
        }
        
    }];
}


+ (void)sendGetRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters callback:(Callback2)callback2
{
    //初始化
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //设置响应类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//text/html  JSON解析
    //请求类型
   [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       //先判断返回值是否为字典类型
       if ([responseObject isKindOfClass:[NSDictionary class]]) {
           //如果位字典 说明返回值类型格式正确，code = 1  成功与否
           
           if (callback2) {
               callback2(NetWorkingReturnSuccess,responseObject);
           }
           return ;

       }
       if (callback2) {
           callback2(NetWorkingReturnFail,nil);
       }
       
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
       
       if (callback2) {
           callback2(0,nil);
       }

   }];
    

}

@end
