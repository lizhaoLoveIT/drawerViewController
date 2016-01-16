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

#pragma mark - tap
- (void)tap:(UITapGestureRecognizer *)tap
{
    [UIView animateKeyframesWithDuration:self.animationDefaultTime delay:0.0 options:(UIViewKeyframeAnimationOptionLayoutSubviews) animations:^{
        self.mainView.frame = self.view.bounds;
    } completion:nil];
}


#pragma mark - 监听滑动手势方法
/**
 * 滑动手势方法
 */
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
            [self setMainViewFrameZero];
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
            [self setMainViewFrameZero];
            return;
        }
    }
    
    // 根据 offsetX 修改 view 的 frame
    self.mainView.frame = [self changeFrameWithOffsetX:offsetX];
    
    // 判断 mainView 的 x 是否大于0，大于0则是右滑，小于0是左滑
    [self isLeftPanOrRightPan];
    
    // 复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
    // 判断当手势结束的时候，定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 定位
        // 1.判断下 manView.x > screenW * scaleOfSelfView ，定位到右边 x = screenW
        if (self.mainView.frame.origin.x > self.scaleOfSelfView * [UIScreen mainScreen].bounds.size.width)
        { // 显示左边的 view
          
            offsetX = [UIScreen mainScreen].bounds.size.width - self.scaleWidth * [UIScreen mainScreen].bounds.size.width - self.mainView.frame.origin.x;

            [UIView animateKeyframesWithDuration:self.animationDefaultTime delay:0.0 options:(UIViewKeyframeAnimationOptionLayoutSubviews) animations:^{
                self.mainView.frame = [self changeFrameWithOffsetX:offsetX];
            } completion:nil];
            
            
        } else if (CGRectGetMaxX(self.mainView.frame) < (1 - self.scaleOfSelfView) * [UIScreen mainScreen].bounds.size.width) { // 显示右边的 view
            
            offsetX = self.scaleWidth * [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.mainView.frame);
            
            [UIView animateKeyframesWithDuration:self.animationDefaultTime delay:0.0 options:(UIViewKeyframeAnimationOptionLayoutSubviews) animations:^{
                self.mainView.frame = [self changeFrameWithOffsetX:offsetX];
            } completion:nil];
            
        } else {
            
            [UIView animateKeyframesWithDuration:self.animationDefaultTime delay:0.0 options:(UIViewKeyframeAnimationOptionLayoutSubviews) animations:^{
                [self setMainViewFrameZero];
            } completion:nil];
        }
    }
}

#pragma mark - 执行复位操作 即 mainView.x == 0
- (void)setMainViewFrameZero
{
    self.mainView.frame = self.view.bounds;

}



#pragma mark - UIGestureRecognizerDelegate

// 是否允许接收手指的触摸点
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        // 获取当前的触摸点
        CGPoint currentPoint = [touch locationInView:self.mainView];
        
        CGFloat selfWidth = self.view.frame.size.width;
        
        return (currentPoint.x < self.scalePan * selfWidth) || (currentPoint.x > selfWidth * (1 - self.scalePan)) ? YES : NO;
    } else {
        return self.mainView.frame.origin.x != 0 ? YES : NO;
    }
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

#pragma mark - 改变 mainView 的 frame
/**
 * 修改 view 的 frame
 */
- (CGRect)changeFrameWithOffsetX:(CGFloat)offsetX
{
    // 取出 frame
    CGRect frame = self.mainView.frame;
    
    // 计算 manView y 轴偏移量 maxY : screenW * offsetx = dy
    CGFloat offsetY = self.mainView.frame.origin.x < 0 ? -(offsetX * self.yHeight / [UIScreen mainScreen].bounds.size.width) * self.scaleHeight : offsetX * self.yHeight / [UIScreen mainScreen].bounds.size.width * self.scaleHeight;
    
    // 计算 main 控件高度的减小量
    CGFloat offsetHeight = 2 * offsetY;
    
    frame.origin.x += offsetX;
    
    frame.origin.y += offsetY;
    
    frame.size.height = frame.size.height - offsetHeight;
    
    return frame;
}

/**
 * 实现监听 mainView 的 左滑或者右滑
 */
- (void)isLeftPanOrRightPan
{
    // 如果 mainView.x 小于0，则看见的时 rightView，如果 mainView.x 大于0，则看见的时 leftView
    if (self.mainView.frame.origin.x <= 0) { // 向左划
        self.rightView.hidden = NO;
    } else { // 向右划
        self.rightView.hidden = YES;
    }
}


#pragma mark - 初始化 view

/**
 * 添加3个视图 view
 */
- (void)setupViews
{
    if (!self.noRightPan) {
        // leftView
        UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
        leftView.backgroundColor = [UIColor orangeColor];
        _leftView = leftView;
        [self.view addSubview:leftView];
    }
    
    if (!self.noLeftPan) {
        // rightView
        UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
            rightView.backgroundColor = [UIColor purpleColor];
        _rightView = rightView;
        [self.view addSubview:rightView];
    }
    
    // mainView
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor redColor];
    _mainView = mainView;
    [self.view addSubview:mainView];
    
    
    // 设置比例系数默认值
    self.scaleWidth = 0.2;
    self.yHeight = 80;
    self.scaleHeight = 1.0;
    self.scalePan = 0.3;
    self.animationDefaultTime = 0.25;
    self.scaleOfSelfView = 0.4;
    self.noLeftPan = NO;
    self.noRightPan = NO;
    _finalFrame = [self changeFrameWithOffsetX:(1 - self.scaleWidth) * self.view.bounds.size.width];
    
}

@end
