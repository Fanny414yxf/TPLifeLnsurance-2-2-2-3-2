//
//  ModelData.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-2.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "ModelData.h"


static ModelData * model = nil;
@implementation ModelData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initData
{
    _agentList = [[NSArray array] init];
}


+ (ModelData *)shearInstance
{
    
    if (!model) {
        model = [[ModelData alloc] init];
    }
    return model;
    
}



@end
