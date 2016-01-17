//
//  AMDrawerViewController.m
//  DrawerViewController
//
//  Created by 李朝 on 15/12/30.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMDrawerViewController.h"

@interface AMDrawerViewController ()<UIGestureRecognizerDelegate>


@end

@implementation AMDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加3个子控件
    [self setupViews];
    
    // 添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.mainView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.mainView addGestureRecognizer:tap];
}

#pragma mark - 初始化 view
#pragma mark -

/**
 * 添加3个视图 view
 */
- (void)setupViews
{
    // 设置比例系数默认值
    self.finalWidthScale = 0.2;
    self.finalY = 80;
    self.originalPanScale = 0.3;
    self.animationDefaultDuration = 0.25;
    self.finalScaleWithoutReset = 0.4;
    self.noLeftPan = NO; // 创建左边的视图
    self.noRightPan = NO; // 创建右边的视图
    
    // mainView
    [self setupMainView];
}

/**
 * 创建 mainView
 */
- (void)setupMainView
{
    if (self.mainView == nil) {
        // mainView
        UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
        mainView.backgroundColor = [UIColor redColor];
        _mainView = mainView;
        [self.view addSubview:mainView];
    }
}

/**
 * 创建 leftView
 */
- (void)setupLeftView
{
    if (self.leftView == nil) {
        UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
        leftView.backgroundColor = [UIColor purpleColor];
        _leftView = leftView;
        [self.view addSubview:leftView];
    }
}

/**
 * 创建 rightView
 */
- (void)setupRightView
{
    if (self.rightView == nil) {
        UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
        rightView.backgroundColor = [UIColor grayColor];
        _rightView = rightView;
        [self.view addSubview:rightView];
    }
}

#pragma mark - setter and getter
#pragma mark -

/**
 * 发现外界重新设置了 finalY、finalWidthScale 的值时，重新设置 finalRightFrame、finalLeftFrame
 */
- (void)setFinalY:(CGFloat)finalY
{
    _finalY = finalY;
    _finalRightFrame = [self calculateRightFinalFrame];
    _finalLeftFrame = [self calculateLeftFinalFrame];
}

- (void)setFinalWidthScale:(CGFloat)finalWidthScale
{
    _finalWidthScale = finalWidthScale;
    _finalRightFrame = [self calculateRightFinalFrame];
    _finalLeftFrame = [self calculateLeftFinalFrame];
}

/**
 * 设置不能左划或者不能右划时，删除 rightView 或者 leftView
 */
- (void)setNoLeftPan:(BOOL)noLeftPan
{
    _noLeftPan = noLeftPan;
    if (noLeftPan) {
        [self.rightView removeFromSuperview];
    } else {
        [self setupRightView];
    }
}

- (void)setNoRightPan:(BOOL)noRightPan
{
    _noRightPan = noRightPan;
    if (noRightPan) {
        [self.leftView removeFromSuperview];
    } else {
        [self setupLeftView];
    }
}

/**
 * 计算 _finalRightFrame 和 _finalLeftFrame
 */
- (CGRect)calculateRightFinalFrame
{
    return [self changeFrameWithOffsetX:(1 - self.finalWidthScale) * self.view.bounds.size.width isMainViewLeft:NO];
}

- (CGRect)calculateLeftFinalFrame
{
    return [self changeFrameWithOffsetX:- (1 - self.finalWidthScale) * self.view.bounds.size.width isMainViewLeft:YES];
}


#pragma mark - 实现 tap 和 pan 手势触发的方法
#pragma mark -

- (void)tap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(drawerViewController:tapMainView:)])
    {
        [self.delegate drawerViewController:self tapMainView:self.mainView];
    } else {
        [self restoreMainViewPoisitionToOriginalWithSituation:(AMDrawerViewControllerSituationNoSituation) withAnimationBlock:nil WithCompletionBlock:nil];
    }
}


- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 获取手势的偏移量
    CGPoint transformPoint = [pan translationInView:self.view];
    
    // 获取 x 轴的偏移量
    CGFloat offsetX = transformPoint.x;
    
    // 判断是否允许左右滑动
    if (self.noLeftPan) {
        if (self.mainView.frame.origin.x == 0) {
            if (offsetX <= 0) {
                return;
            }
        } else if (self.mainView.frame.origin.x < 0) {
            self.mainView.frame = self.view.bounds;
            return;
        }
    }
    
    // 判断是否允许右滑
    if (self.noRightPan) {
        if (self.mainView.frame.origin.x == 0) {
            if (offsetX >= 0) {
                return;
            }
        } else if (self.mainView.frame.origin.x > 0) {
            self.mainView.frame = self.view.bounds;
            return;
        }
    }
    
    // 如果 mainViewX > 0.8 * self.vew 且 offsetX > 0 return
    if (self.mainView.frame.origin.x >= (1 - self.finalWidthScale) * self.view.frame.size.width && offsetX >= 0)
    {
        self.mainView.frame = self.finalRightFrame;
        self.leftView.frame = self.view.bounds;
        return;
    }
    
    if (CGRectGetMaxX(self.mainView.frame) <= self.finalWidthScale * self.view.frame.size.width && offsetX <= 0) {
        self.mainView.frame = self.finalLeftFrame;
        self.rightView.frame = self.view.bounds;
        return;
    }
    
    
    
    // 监听开始拖拽
    if (pan.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(drawerViewController:beginToPanMainView:withBeginX:)]) {
            [self.delegate drawerViewController:self beginToPanMainView:self.mainView withBeginX:self.mainView.frame.origin.x];
        }
    }
    
    // 根据 offsetX 修改 view 的 frame
    self.mainView.frame = [self changeFrameWithOffsetX:offsetX isMainViewLeft:self.mainView.frame.origin.x < 0];
    
    // 拖拽时调用
    if ([self.delegate respondsToSelector:@selector(drawerViewController:didPanMainView:withOffsetX:)]) {
        [self.delegate drawerViewController:self didPanMainView:self.mainView withOffsetX:offsetX];
    }
    
    
    // 判断 mainView 的 x 是否大于0，大于0则是右滑，小于0是左滑
    [self isLeftPanOrRightPan];
    
    // 复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
    // 判断当手势结束的时候，定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 定位
        // 1.判断下 manView.x > screenW * finalScaleWithoutReset ，定位到右边 x = screenW
        if (self.mainView.frame.origin.x > self.finalScaleWithoutReset * [UIScreen mainScreen].bounds.size.width)
        { // 显示左边的 view
            offsetX = [UIScreen mainScreen].bounds.size.width - self.finalWidthScale * [UIScreen mainScreen].bounds.size.width - self.mainView.frame.origin.x;
           
            CGRect frame = [self changeFrameWithOffsetX:offsetX isMainViewLeft:self.mainView.frame.origin.x < 0];
            
            [self changeMainViewFrameByFrame:frame inSituation:(AMDrawerViewControllerSituationRight) withAnimationBlock:nil andCompletionBlock:nil];
            
        } else if (CGRectGetMaxX(self.mainView.frame) < (1 - self.finalScaleWithoutReset) * [UIScreen mainScreen].bounds.size.width)
        { // 显示右边的 view
            offsetX = self.finalWidthScale * [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.mainView.frame);
           
            CGRect frame = [self changeFrameWithOffsetX:offsetX isMainViewLeft:self.mainView.frame.origin.x < 0];
            
            [self changeMainViewFrameByFrame:frame inSituation:(AMDrawerViewControllerSituationLeft) withAnimationBlock:nil andCompletionBlock:nil];
            
        } else
        { // 复位
            [self restoreMainViewPoisitionToOriginalWithSituation:(AMDrawerViewControllerSituationRestore) withAnimationBlock:nil WithCompletionBlock:nil];
        }
    }
}

#pragma mark - 给变化的 frame 添加动画效果

/** 
 * 给我一个 frame，我让 mainView 及其子控件带有动画效果的变成这个 frame
 */
- (void)changeMainViewFrameByFrame:(CGRect)frame inSituation:(AMDrawerViewControllerSituation)situation withAnimationBlock:(void(^)(AMDrawerViewController *, CGFloat))animationBlock andCompletionBlock:(void (^)(AMDrawerViewController *))completionBlock
{
    
    if (situation != AMDrawerViewControllerSituationNoSituation) {
        if ([self.delegate respondsToSelector:@selector(drawerViewController:didEndPanMainView:withSituation:withFinalX:)]) {
            [self.delegate drawerViewController:self didEndPanMainView:self.mainView withSituation:situation withFinalX:self.mainView.frame.origin.x];
        }
    }
    [UIView animateKeyframesWithDuration:self.animationDefaultDuration delay:0.0 options:(UIViewKeyframeAnimationOptionLayoutSubviews) animations:^{
        self.mainView.frame = frame;
        if (animationBlock != nil) {
            animationBlock(self, self.animationDefaultDuration);
        }
    } completion:^(BOOL finished) {
        if (completionBlock != nil) {
            completionBlock(self);
        }
    }];
}

#pragma mark - 手势修改 mainView 的 frame，会频繁调用下面方法

/**
 * 判断 mainView 是否在左边，通过 X 轴偏移量重新计算 mainView 的 frame
 */
- (CGRect)changeFrameWithOffsetX:(CGFloat)offsetX isMainViewLeft:(BOOL)isLeft
{
    // 取出 frame
    CGRect frame = self.mainView.frame;
    
    // 计算 manView y 轴偏移量 maxY : screenW * offsetx = dy
    CGFloat offsetY = [self calculateOffsetYWithOffsetX:offsetX isMainViewLeft:isLeft];
    
    // 计算 main 控件高度的减小量
    CGFloat offsetHeight = 2 * offsetY;
    
    frame.origin.x += offsetX;
    
    frame.origin.y += offsetY;
    
    frame.size.height = frame.size.height - offsetHeight;
    
    return frame;
}

/**
 * 判断 mainView 是否在左边，通过 X 轴偏移量计算 Y 轴偏移量
 */
- (CGFloat)calculateOffsetYWithOffsetX:(CGFloat)offsetX isMainViewLeft:(BOOL)isLeft
{
    return isLeft ? - (offsetX * self.finalY / [UIScreen mainScreen].bounds.size.width) : offsetX * self.finalY / [UIScreen mainScreen].bounds.size.width;
}



#pragma mark - 实现 UIGestureRecognizerDelegate 的代理方法
#pragma mark -

/**
 * 是否允许接收手指的触摸点
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) { // 判断是 tap 还是 pan
        // 获取当前的触摸点
        CGPoint currentPoint = [touch locationInView:self.mainView];

        CGFloat selfWidth = self.view.frame.size.width;
        
        return (currentPoint.x < self.originalPanScale * selfWidth) || (currentPoint.x > selfWidth * (1 - self.originalPanScale))? YES : NO;
    } else {
        return self.mainView.frame.origin.x != 0 ? YES : NO;
    }
}

/**
 * 监听 mainView 的 左滑或者右滑
 */
- (void)isLeftPanOrRightPan
{
    // 如果 mainView.x 小于0，则看见的时 rightView，如果 mainView.x 大于0，则看见的时 leftView
    if (self.mainView.frame.origin.x <= 0) { // 向左划
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
    } else { // 向右划
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
    }
}

#pragma mark - 给外界调用的接口
#pragma mark -



/** 
 * 通过代码将 mainView 从初始位置移动到最右边，同时显示 leftView
 */
- (void)moveMainViewToRightFinalPositionFromOriginalWithAnimationBlock:(void (^)(AMDrawerViewController *, CGFloat))animationBlock WithCompletionBlock:(void (^)(AMDrawerViewController *))completionBlock
{
    if (self.noRightPan) {
        return;
    }
    [self changeMainViewFrameByFrame:self.finalRightFrame inSituation:AMDrawerViewControllerSituationNoSituation withAnimationBlock:animationBlock andCompletionBlock:completionBlock];
}

/** 
 * 通过代码将 mainView 从初始位置移动到最左边，同时显示 rightView
 */
- (void)moveMainViewToLeftFinalPositionFromOriginalWithAnimationBlock:(void (^)(AMDrawerViewController *, CGFloat))animationBlock WithCompletionBlock:(void (^)(AMDrawerViewController *))completionBlock
{
    if (self.noLeftPan) {
        return;
    }
    [self changeMainViewFrameByFrame:self.finalLeftFrame inSituation:AMDrawerViewControllerSituationNoSituation withAnimationBlock:animationBlock andCompletionBlock:completionBlock];
}

/** 
 * 恢复 mainView 的初始位置 
 */
- (void)restoreMainViewPoisitionToOriginalWithSituation:(AMDrawerViewControllerSituation)situation withAnimationBlock:(void (^)(AMDrawerViewController *, CGFloat))animationBlock WithCompletionBlock:(void (^)(AMDrawerViewController *))completionBlock
{
    if (self.mainView.frame.origin.x != 0) {
        [self changeMainViewFrameByFrame:self.view.bounds inSituation:situation withAnimationBlock:animationBlock andCompletionBlock:completionBlock];
    }
}

@end
