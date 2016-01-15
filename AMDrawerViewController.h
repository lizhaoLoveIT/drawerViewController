//
//  AMDrawerViewController.h
//  DrawerViewController
//
//  Created by 李朝 on 15/12/30.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMDrawerViewController;

@interface AMDrawerViewController : UIViewController


/** leftView */
@property (weak, nonatomic, readonly) UIView *leftView;

/** rightView */
@property (strong, nonatomic, readonly) UIView *rightView;

/** mainView */
@property (strong, nonatomic, readonly) UIView *mainView;

/** 控制抽屉的宽度 范围(小0.1 ~ 0.5大)， 默认0.2 */
@property (assign, nonatomic) CGFloat scaleWidth;

/** 设置抽屉最终高度的 y 值，默认为80 */
@property (assign, nonatomic) CGFloat yHeight;

/** 高度缩小比例，范围(大0.0 ~ 1.0小)，默认是1.0 */
@property (assign, nonatomic) CGFloat scaleHeight; ;

/** 控制允许左右滑动的触摸点比例，默认时0.3 */
@property (assign, nonatomic) CGFloat scalePan;

/** 当手势结束时执行动画时间，默认0.25 */
@property (assign, nonatomic) CGFloat animationDefaultTime;

/** 将 mainView 拖过 self.view 的百分之多少不会自动归位 默认 0.4*/
@property (assign, nonatomic) CGFloat scaleOfSelfView;

/** 取消右边的 view 展示(取消左划)，默认为 No */
@property (assign, nonatomic) BOOL noLeftPan;

/** 取消左边 view 的展示(取消右滑)，默认为 No */
@property (assign, nonatomic) BOOL noRightPan;

/** 最终的 frame 值 */
@property (assign, nonatomic, readonly) CGRect finalFrame;

@end
