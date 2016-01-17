//
//  AMDrawerViewController.h
//  DrawerViewController
//
//  Created by 李朝 on 15/12/30.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMDrawerViewController;

/**
 * 记录结束拖拽时，mainView 面临的3种情况，分别是：
 */
typedef enum : NSUInteger {
    AMDrawerViewControllerSituationNoSituation = 0, // 这个选项说明 mainView 并没有处于结束拖拽状态
    AMDrawerViewControllerSituationRestore, // 恢复初始位置情形
    AMDrawerViewControllerSituationLeft, // 自动靠向左边
    AMDrawerViewControllerSituationRight // 自动靠向右边
} AMDrawerViewControllerSituation;

@protocol AMDrawerViewControllerDelegate <NSObject>

@optional

/**
 * 监听到用户 tap mainView。如果你没有设置该代理，mainView 不在初始位置的时候，
 * 当你 tap mainView ，我们会帮你将 mainView 还原到初始位置，如果你设置了该代理，则需要你自己调用
 * - (void)restoreMainViewPoisitionToOriginalWithSituation:withAnimationBlock:WithCompletionBlock:
 方法，你可以将你的代码写到对应的 block 中，我们会相应的为您实现动画效果
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController tapMainView:(UIView *)mainView;

/**
 * 监听到用户开始拖拽
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController beginToPanMainView:(UIView *)mainView withBeginX:(CGFloat)mainViewX;

/** 
 * 监听到拖拽手势
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController didPanMainView:(UIView *)mainView withOffsetX:(CGFloat)offsetX;
/** 
 * 监听到到拖拽手势结束
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController didEndPanMainView:(UIView *)mainView withSituation:(AMDrawerViewControllerSituation)situation withFinalX:(CGFloat)mainViewX;

@end

@interface AMDrawerViewController : UIViewController


/** leftView */
@property (weak, nonatomic, readonly) UIView *leftView;

/** rightView */
@property (weak, nonatomic, readonly) UIView *rightView;

/** mainView */
@property (weak, nonatomic, readonly) UIView *mainView;

/** 代理 */
@property (weak, nonatomic) id<AMDrawerViewControllerDelegate> delegate;

/** 控制抽屉的宽度 范围(小0.1 ~ 0.5大)， 默认0.2 */
@property (assign, nonatomic) CGFloat finalWidthScale;

/** 设置抽屉最终高度的 y 值，默认为80 */
@property (assign, nonatomic) CGFloat finalY;

/** 控制开始拖拽时允许左右滑动的触摸点占宽度的比例，默认时0.3 */
@property (assign, nonatomic) CGFloat originalPanScale;

/** 将 mainView 拖过 self.view 的百分之多少不会自动归位 默认 0.4*/
@property (assign, nonatomic) CGFloat finalScaleWithoutReset;

/** 当手势结束时执行动画时间，默认0.25 */
@property (assign, nonatomic) CGFloat animationDefaultDuration;

/** 取消右边的 view 展示(取消左划)，默认为 No */
@property (assign, nonatomic) BOOL noLeftPan;

/** 取消左边 view 的展示(取消右滑)，默认为 No */
@property (assign, nonatomic) BOOL noRightPan;

/** 计算 mainView右移 最终的 frame 值 */
@property (assign, nonatomic, readonly) CGRect finalRightFrame;

/** 计算 mainView 左移 最终的 frame 值 */
@property (assign, nonatomic, readonly) CGRect finalLeftFrame;

/**
 * 将 mainView 从初始位置移动到最右边，同时显示 leftView
 */
- (void)moveMainViewToRightFinalPositionFromOriginalWithAnimationBlock:(void(^)(AMDrawerViewController *drawerViewController, CGFloat animationDuration))animationBlock WithCompletionBlock:(void(^)(AMDrawerViewController *drawerViewController))completionBlock;

/**
 * 将 mainView 从初始位置移动到最左边，同时显示 rightView
 */
- (void)moveMainViewToLeftFinalPositionFromOriginalWithAnimationBlock:(void(^)(AMDrawerViewController *drawerViewController, CGFloat animationDuration))animationBlock WithCompletionBlock:(void(^)(AMDrawerViewController *drawerViewController))completionBlock;

/**
 * 恢复 mainView 的初始位置，用户敲击 mainView 时，如果 mainView 不在初始位置，将会调用这个方法
 */
- (void)restoreMainViewPoisitionToOriginalWithSituation:(AMDrawerViewControllerSituation)situation withAnimationBlock:(void(^)(AMDrawerViewController *drawerViewController, CGFloat animationDuration))animationBlock WithCompletionBlock:(void(^)(AMDrawerViewController *drawerViewController))completionBlock;

@end
