//
//  LoginInforCenter.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-2.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "LoginInforCenter.h"


static LoginInforCenter * login = nil;
@implementation LoginInforCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLogin = NO;
    }
    return self;
}


+ (LoginInforCenter *)shearLoginInformation
{
    
    if (!login) {
        login = [[LoginInforCenter alloc] init];
    }
    return login;
    
}



@end
