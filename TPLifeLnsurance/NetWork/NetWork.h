//
//  NetWork.h
//  网络请求1
//
//  Created by rimi on 15-1-21.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Callback2) (int code,NSDictionary * result);//int code 进行判断
typedef void(^Callback) (id result);
NS_ENUM(NSInteger, NetWorkingReturnTyoe)
{
    NetWorkingReturnSuccess = 0,
    NetWorkingReturnFail = 1,
};

@interface NetWork : NSObject

+ (void)sendPostRequestWithURL:(NSString *)url parameters:(NSDictionary *)parmeters callback:(Callback)callback;
+ (void)sendGetRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters callback:(Callback2)callback2;

@end
