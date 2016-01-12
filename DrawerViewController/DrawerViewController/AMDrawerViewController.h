//
//  AMDrawerViewController.h
//  DrawerViewController
//
//  Created by 李朝 on 15/12/30.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMMainView.h"

@interface AMDrawerViewController : UIViewController


/** leftView */
@property (weak, nonatomic, readonly) UIView *leftView;

/** rightView */
@property (strong, nonatomic, readonly) UIView *rightView;

/** mainView */
@property (strong, nonatomic, readonly) AMMainView *mainView;

/** 控制抽屉的宽度 范围(小0.1 ~ 0.5大) */
@property (assign, nonatomic) CGFloat scaleWidth;

/** 高度缩小比例，范围(大0.0 ~ 1.0小) */
@property (assign, nonatomic) CGFloat scaleHeight; ;

@end
