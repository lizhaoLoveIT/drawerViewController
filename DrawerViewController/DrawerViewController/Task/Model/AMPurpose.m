//
//  AMPurpose.m
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import "AMPurpose.h"

@implementation AMPurpose

+ (instancetype)purposeWithDict:(NSDictionary *)dict
{
    AMPurpose *purpose = [[self alloc] init];
    [purpose setValuesForKeysWithDictionary:dict];
    
    return purpose;
}

@end
