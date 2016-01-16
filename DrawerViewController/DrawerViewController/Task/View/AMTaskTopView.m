//
//  AMTaskTopView.m
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import "AMTaskTopView.h"

@interface AMTaskTopView ()

/** 头像按钮 */
@property (weak, nonatomic) IBOutlet UIButton *headButton;
/** 显示当前日期 */
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
/** 显示日历日期 */
@property (weak, nonatomic) IBOutlet UILabel *taskDateLabel;
/** 当前时间 */
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@end

@implementation AMTaskTopView

#pragma mark - 创建及初始化


+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor grayColor];
}


#pragma mark - 点击了 headButton

/**
 * 点击了 headButton
 */

- (IBAction)clickHeadButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(topView:DidClickHeadButton:)]) {
        [self.delegate topView:self DidClickHeadButton:self.headButton];
    }
}

@end
