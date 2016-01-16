//
//  AMTaskTopView.h
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/15.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMTaskTopView;

@protocol AMTaskTopViewDelegate <NSObject>

- (void)topView:(AMTaskTopView *)topView DidClickHeadButton:(UIButton *)headButton;

@end

@interface AMTaskTopView : UIView

/** 代理 */
@property (weak, nonatomic) id<AMTaskTopViewDelegate> delegate;

+ (instancetype)viewFromXib;

@end
