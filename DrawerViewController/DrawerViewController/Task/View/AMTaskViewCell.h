//
//  AMTaskViewCell.h
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMPurpose;
@interface AMTaskViewCell : UITableViewCell

/** AMPurpose */
@property (strong, nonatomic) AMPurpose *purpose;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
