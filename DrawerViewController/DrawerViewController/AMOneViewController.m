//
//  AMOneViewController.m
//  DrawerViewController
//
//  Created by 李朝 on 16/1/18.
//  Copyright © 2016年 ammar. All rights reserved.
//

#import "AMOneViewController.h"
#import "AMDrawerViewController.h"
#import "AMMainViewController.h"

@interface AMOneViewController ()<AMDrawerViewControllerDelegate>

@property (weak, nonatomic) AMMainViewController *mainVc;

@end

@implementation AMOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainVc = (AMMainViewController *)self.parentViewController;
    self.mainVc.delegate = self;
}

- (IBAction)clickTwoButton:(id)sender {
    if (self.mainVc.mainView.frame.origin.x != 0) { // 说明我在右边哦
        // 使用这个方法可以将我复原
        [self.mainVc restoreMainViewPoisitionToOriginalWithSituation:(AMDrawerViewControllerSituationNoSituation) withAnimationBlock:^(AMDrawerViewController *drawerViewController, CGFloat animationDuration) {
            NSLog(@"restore 复原时要做动画的代码写这里");
        } WithCompletionBlock:^(AMDrawerViewController *drawerViewController) {
            NSLog(@"restore 复原完成时会调用这个 block");
        }];
    } else {
        [self.mainVc moveMainViewToRightFinalPositionFromOriginalWithAnimationBlock:^(AMDrawerViewController *drawerViewController, CGFloat animationDuration) {
            NSLog(@"这个地方你写的代码会加动画哦，你点击 two 的时候，我会帮你把 mainView 移动到最右边");
        } WithCompletionBlock:^(AMDrawerViewController *drawerViewController) {
            NSLog(@"动画结束时的代码写在我这里");
        }];
    }
    
}


- (IBAction)clickTreeButton:(id)sender {
    if (self.mainVc.mainView.frame.origin.x != 0) {
        [self.mainVc restoreMainViewPoisitionToOriginalWithSituation:(AMDrawerViewControllerSituationNoSituation) withAnimationBlock:^(AMDrawerViewController *drawerViewController, CGFloat animationDuration) {
            NSLog(@"restore 复原时要做动画的代码写这里");
        } WithCompletionBlock:^(AMDrawerViewController *drawerViewController) {
            NSLog(@"restore 复原完成时会调用这个 block");
        }];

    } else {
        [self.mainVc moveMainViewToLeftFinalPositionFromOriginalWithAnimationBlock:^(AMDrawerViewController *drawerViewController, CGFloat animationDuration) {
            NSLog(@"我是相反的");
        } WithCompletionBlock:^(AMDrawerViewController *drawerViewController) {
            NSLog(@"废话不多说");
        }];
    }
}

#pragma mark - AMDrawerViewControllerDelegate

/**
 * 开始拖拽时调用
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController beginToPanMainView:(UIView *)mainView withBeginX:(CGFloat)mainViewX
{
    NSLog(@"用户开始拖拽我了，~我是：%@，从%.2f开始拖拽的", mainView, mainViewX);
}

/**
 * 结束拖拽时
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController didEndPanMainView:(UIView *)mainView withSituation:(AMDrawerViewControllerSituation)situation withFinalX:(CGFloat)mainViewX
{
    NSLog(@"用户松开我了，利用 situation 可以更好的判断用户松开我后，我做了些什么。我是：%@", mainView);
}

/**
 * 正在拖拽时
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController didPanMainView:(UIView *)mainView withOffsetX:(CGFloat)offsetX
{
    NSLog(@"我正在被拖拽，我回被平凡的调用，我这次被拖拽了%.2f个像素，负数代表向 X 轴的负方向拖拽", offsetX);
}

/**
 * 如果没有设置这个代理，点击 mainView 会默认还原初始位置，如果设置了代理，需要自己实现还原初始位置的代码
 * 调用-(void)restoreMainViewPoisitionToOriginalWithSituation:withAnimationBlock:WithCompletionBlock:
 * 你可以在 block 中实现相应的动画效果
 */
- (void)drawerViewController:(AMDrawerViewController *)drawerViewController tapMainView:(UIView *)mainView
{
    NSLog(@"注意这个方法调用的时机，你也可以将该方法注释掉，看看会发生什么。");
}

@end
