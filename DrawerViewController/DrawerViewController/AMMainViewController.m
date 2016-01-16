//
//  AMMainViewController.m
//  DrawerViewController
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 ammar. All rights reserved.
//

#import "AMMainViewController.h"
#import "AMViewController.h"
#import "AMOneViewController.h"

@interface AMMainViewController ()

@end

@implementation AMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AMOneViewController *vc = [[AMOneViewController alloc] init];
    [self addChildViewController:vc];
    [self.mainView addSubview:vc.view];
    vc.view.frame = self.mainView.bounds;
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
