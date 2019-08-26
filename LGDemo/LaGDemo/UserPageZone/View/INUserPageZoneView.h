//
//  INUserPageZoneView.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"
#import "INUserPageSegmentView.h"
#import "INUserPageHeaderView.h"

@interface INUserPageZoneView : UIView <UIScrollViewDelegate,INUserPageSegmentViewDelegate>

@property (nonatomic, weak) id delegate;

// headerView
@property (nonatomic, strong) INUserPageHeaderView *headerView;
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, strong) INUserPageSegmentView *segmentView;

// 底部滚动的view
@property (nonatomic, strong) UIScrollView *scrollView;

// 底部分页ScrollView
@property (nonatomic, strong) UIScrollView *pageScrollView;

// 显示底部操作的view
@property (nonatomic, strong) UIView *contentBGView;

@property (nonatomic) CGRect originFrame;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@property (nonatomic, assign) CGFloat maxContentOffsetY;

- (id)initWithFrame:(CGRect)frame;

@end
