//
//  AMTaskViewController.m
//  娟娟任务管理器
//
//  Created by 李朝 on 16/1/14.
//  Copyright © 2016年 lizhao. All rights reserved.
//

#import "AMTaskViewController.h"

#import "AMTaskTopView.h"
#import "AMCalendarView.h"
#import "AMTaskViewCell.h"

#import "AMPurpose.h"


#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

@interface AMTaskViewController () <UITableViewDataSource, UITableViewDelegate, AMTaskTopViewDelegate>
/** taskTableView */
@property (weak, nonatomic) UITableView *taskTableView;
/** topView */
@property (weak, nonatomic) AMTaskTopView *topView;
/** calendarView */
@property (weak, nonatomic) AMCalendarView *calendarView;

/** 最终目标数组 */
@property (strong, nonatomic) NSMutableArray *purposes;

@end

@implementation AMTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    // 初始化 topView
    [self setupTopView];
    
    // 初始化 taskTableView
    [self setupTaskTableView];
    
    // 初始化 calendarView
    [self setupCalendarView];
}


#pragma mark - 初始化
#pragma mark -

/**
 * 初始化 topView
 */
- (void)setupTopView
{
    // 布局
    [self layoutTopView];
    self.topView.delegate = self;
}

/**
 * 初始化 taskTableView
 */
- (void)setupTaskTableView
{
    // 布局
    [self layoutTaskTableView];
    
    // 取消分割线
    self.taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 * 初始化 calendarView
 */
- (void)setupCalendarView
{
    // 布局
    [self layoutCalendarView];

    self.calendarView.backgroundColor = [UIColor yellowColor];
}

#pragma mark - delegate
#pragma mark -


#pragma mark - taskTableView DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.purposes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMTaskViewCell *cell = [AMTaskViewCell cellWithTableView:tableView];
    
    cell.purpose = self.purposes[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - AMTaskTopViewDelegate
- (void)topView:(AMTaskTopView *)topView DidClickHeadButton:(UIButton *)headButton
{
    
}


#pragma mark - 懒加载
#pragma mark -


/**
 * taskTableView
 */
- (UITableView *)taskTableView
{
    if (_taskTableView == nil) {
        
        UITableView *taskTableView = [[UITableView alloc] init];
        [self.view addSubview:taskTableView];
        taskTableView.delegate = self;
        taskTableView.dataSource = self;
        _taskTableView = taskTableView;
    }
    return _taskTableView;
}

/**
 * topView
 */
- (AMTaskTopView *)topView
{
    if (_topView == nil) {
        AMTaskTopView *topView = [AMTaskTopView viewFromXib];
        [self.view addSubview:topView];
        _topView = topView;
    }
    return _topView;
}


/**
 * calendarView
 */
- (AMCalendarView *)calendarView
{
    if (_calendarView == nil) {
        
        AMCalendarView *calendarView = [[AMCalendarView alloc] init];
        [self.view addSubview:calendarView];
        _calendarView = calendarView;
    }
    return _calendarView;
}


/**
 * purpose
 */
- (NSMutableArray *)purposes
{
    if (_purposes == nil) {
        
        _purposes = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            AMPurpose *purpose = [AMPurpose purposeWithDict:@{@"test" : [NSString stringWithFormat:@"test---%zd", i]}];
            [_purposes addObject:purpose];
        }
    }
    return _purposes;
}

#pragma mark - 布局子控件
#pragma mark -

/**
 * layoutTopView
 */
- (void)layoutTopView
{
    [self.topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(64);
    }];
}

/**
 * layoutTaskTableView
 */
- (void)layoutTaskTableView
{
    [self.taskTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.bottom);
        make.width.equalTo(109);
    }];
}

/**
 * layoutCalendarView
 */
- (void)layoutCalendarView
{
    [self.calendarView makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.bottom);
        make.left.equalTo(self.taskTableView.right);
    }];
}

@end
