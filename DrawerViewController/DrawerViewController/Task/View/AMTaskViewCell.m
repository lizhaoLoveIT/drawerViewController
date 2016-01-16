//
//  AMTaskViewCell.m
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import "AMTaskViewCell.h"
#import "AMPurpose.h"

@interface AMTaskViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *purposeTitleLabel;

@end

@implementation AMTaskViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    AMTaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
    self.purposeTitleLabel.highlightedTextColor = [UIColor orangeColor];
}

- (void)setPurpose:(AMPurpose *)purpose
{
    _purpose = purpose;
    self.purposeTitleLabel.text = purpose.test;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
