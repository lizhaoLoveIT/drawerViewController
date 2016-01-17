//
//  AMMainViewController.m
//  DrawerViewController
//
//  Created by 李朝 on 16/1/18.
//  Copyright © 2016年 ammar. All rights reserved.
//

#import "AMMainViewController.h"

#import "AMOneViewController.h"

@interface AMMainViewController ()

@end

@implementation AMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/***********************************    你可以根据需求随意调整或者进行测试    ***************************************/
    /** 控制抽屉的宽度 范围(小0.1 ~ 0.5大)， 默认0.2 */
    self.finalWidthScale = 0.2;
    
    /** 设置抽屉最终高度的 y 值，默认为80 */
    self.finalY = 80;
    
    /** 控制开始拖拽时允许左右滑动的触摸点占宽度的比例，默认时0.3 */
    self.originalPanScale = 0.3;
    
    /** 将 mainView 拖过 self.view(screenWidth) 的百分之多少不会自动归位 默认 0.4*/
    self.finalScaleWithoutReset = 0.4;
    
    /** 当手势结束时执行动画时间，默认0.25 */
    self.animationDefaultDuration = 0.25;
    
    /** 取消右边的 view 展示(取消左划)，默认为 No */
    self.noLeftPan = NO;
    
    /** 取消左边 view 的展示(取消右滑)，默认为 No */
    self.noRightPan = NO;
    
    /** mainView右移 最终的 frame 值 */
    NSLog(@"finalRightFrame--------------%@", NSStringFromCGRect(self.finalRightFrame));
    
    /** mainView 左移 最终的 frame 值 */
    NSLog(@"finalLeftFrame---------------%@", NSStringFromCGRect(self.finalLeftFrame));
    
    AMOneViewController *one = [[AMOneViewController alloc] init];
    [self addChildViewController:one];
    [self.mainView addSubview:one.view];
    one.view.frame = self.mainView.bounds;
}

@end
