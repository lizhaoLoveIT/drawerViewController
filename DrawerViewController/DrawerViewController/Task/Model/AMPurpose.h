//
//  AMPurpose.h
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPurpose : NSObject

/** test */
@property (strong, nonatomic) NSString *test;

+ (instancetype)purposeWithDict:(NSDictionary *)dict;

@end
