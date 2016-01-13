//
//  AMDrawerViewController.m
//  DrawerViewController
//
//  Created by 李朝 on 15/12/30.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMDrawerViewController.h"


// 屏幕的宽度和高度
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

// 控制抽屉的大小 范围(0.1 ~ 0.5)
//#define kScale 0.2

// 最终的 y 值
#define kFinalY 80

@interface AMDrawerViewController ()<UIGestureRecognizerDelegate>


@end

@implementation AMDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加3个子控件
    [self setupViews];
    
    // 设置手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

#pragma mark - 滑动手势方法
/**
 * 滑动手势方法
 */
- (void)pan:(UIPanGestureRecognizer *)pan
{
//    // 获取手势的触摸点
//    CGPoint currentPoint = [pan locationInView:self.view];
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        if (currentPoint.x >= 50) {
//            return;
//        }
//    }
    
    // 获取手势的偏移量
    CGPoint transformPoint = [pan translationInView:self.view];
    
    // 获取 x 轴的偏移量
    CGFloat offsetX = transformPoint.x;
    
    // 根据 offsetX 修改 view 的 frame
    self.mainView.frame = [self changeFrameWithOffsetX:offsetX];
    
    // 判断 mainView 的 x 是否大于0，大于0则是右滑，小于0是左滑
    [self isLeftPanOrRightPan];
    
    // 复位
    [pan setTranslation:CGPointZero inView:self.view];
    
    // 判断当手势结束的时候，定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 定位
        // 1.判断下 manView.x > screenW * 0.5 ，定位到右边 x = screenW
        if (self.mainView.frame.origin.x > 0.5 * kScreenW) { // 显示左边的 view
          
            offsetX = kScreenW - self.scaleWidth * kScreenW - self.mainView.frame.origin.x;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.mainView.frame = [self changeFrameWithOffsetX:offsetX];
            }];
            
        } else if (CGRectGetMaxX(self.mainView.frame) < 0.5 * kScreenW) { // 显示右边的 view
            
            offsetX = self.scaleWidth * kScreenW - CGRectGetMaxX(self.mainView.frame);
            
            [UIView animateWithDuration:0.25 animations:^{
                self.mainView.frame = [self changeFrameWithOffsetX:offsetX];
            }];
            
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.mainView.frame = self.view.bounds;
            }];
            
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
// 是否允许接收手指的触摸点
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 获取当前的触摸点
    CGPoint currentPoint = [touch locationInView:self.mainView];
    
    CGFloat selfWidth = self.view.frame.size.width;
    return (currentPoint.x < self.scalePan * selfWidth) || (currentPoint.x > selfWidth * (1 - self.scalePan)) ? YES : NO;
}


#pragma mark - 改变 mainView 的 frame
/**
 * 修改 view 的 frame
 */
- (CGRect)changeFrameWithOffsetX:(CGFloat)offsetX
{
    // 取出 frame
    CGRect frame = self.mainView.frame;
    
    // 计算 manView y 轴偏移量 maxY : screenW * offsetx = dy
    CGFloat offsetY = self.mainView.frame.origin.x < 0 ? -(offsetX * kFinalY / kScreenW) * self.scaleHeight : offsetX * kFinalY / kScreenW * self.scaleHeight;
    
    // 计算 main 控件高度的减小量
    CGFloat offsetHeight = 2 * offsetY;
    
    // 计算 main 控件宽度的减小量
    CGFloat offsetWidth = offsetHeight * frame.size.width / frame.size.height;
    
    frame.origin.x += offsetX;
    
    frame.origin.y += offsetY;
    
    frame.size.height = frame.size.height - offsetHeight;
    
    frame.size.width = frame.size.width - offsetWidth;
    
    return frame;
}

/**
 * 实现监听 mainView 的 左滑或者右滑
 */
- (void)isLeftPanOrRightPan
{
    // 如果 mainView.x 小于0，则看见的时 rightView，如果 mainView.x 大于0，则看见的时 leftView
    if (self.mainView.frame.origin.x <= 0) {
        self.rightView.hidden = NO;
    } else {
        self.rightView.hidden = YES;
    }
}


#pragma mark - 初始化 view

/**
 * 添加3个视图 view
 */
- (void)setupViews
{

    // leftView
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    _leftView = leftView;
    
    [self.view addSubview:leftView];
    
    
    // rightView
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    _rightView = rightView;
    
    [self.view addSubview:rightView];
    
    
    // mainView
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    _mainView = mainView;
  
    [self.view addSubview:mainView];
    
    // 比例系数默认等于0.2
    self.scaleWidth = 0.2;
    self.scaleHeight = 1.0;
    self.scalePan = 0.23;
}

@end
