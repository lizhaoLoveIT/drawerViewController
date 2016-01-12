//
//  AMMainView.h
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/11.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AMMainViewBlock)();

@interface AMMainView : UIView

/** AMMainViewBlock */
@property (copy, nonatomic) AMMainViewBlock block;

/** 监听 mainView 的敲击 */
- (void)tapMainView:(UITapGestureRecognizer *)tap;

@end
