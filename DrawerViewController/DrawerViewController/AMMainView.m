//
//  AMMainView.m
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/11.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import "AMMainView.h"

@implementation AMMainView

- (void)tapMainView:(UITapGestureRecognizer *)tap
{
    if (self.block != nil) {
        self.block();
    }
}


@end
