//
//  AMMainViewController.m
//  DrawerViewController
//
//  Created by 李朝 on 16/1/1.
//  Copyright © 2016年 ammar. All rights reserved.
//

#import "AMMainViewController.h"
#import "AMViewController.h"

@interface AMMainViewController ()

@end

@implementation AMMainViewController

// 当 A 控制器的 view 成为 B 控制器的 view 的子控件时，A 控制器也一定要成为 B 控制器的子控制器，否则无法监听到 A 控制器内 view 的事件触发

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建 tableView
    AMViewController *vc = [[AMViewController alloc] init];
    
    vc.view.frame = self.mainView.bounds;
    
    [self addChildViewController:vc];
    
    [self.mainView addSubview:vc.view];
    
    self.scaleHeight = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
