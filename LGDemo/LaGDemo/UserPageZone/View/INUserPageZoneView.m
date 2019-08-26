//
//  INUserPageZoneView.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import "INUserPageZoneView.h"
#import "UIColor+Addition.h"

@implementation INUserPageZoneView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.exclusiveTouch = YES;
        _scrollView.tag = 100;
        [self addSubview:_scrollView];
        
        self.scrollView.frame = self.bounds;
        
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        self.headerHeight = [INUserPageHeaderView headerHeight];
        self.maxContentOffsetY = [INUserPageHeaderView headerHeight] - statusBarFrame.size.height;

        _headerView = [[INUserPageHeaderView alloc] initWithFrame:CGRectZero];
        [self.scrollView addSubview:_headerView];
        _headerView.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.headerHeight);
        
        _contentBGView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentBGView.alpha = 0.0;
        _contentBGView.backgroundColor = [UIColor blackColor];
        _contentBGView.userInteractionEnabled = NO;
        [self.scrollView addSubview:_contentBGView];
        _contentBGView.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height + self.headerHeight + 44.0);
        
        self.segmentView = [[INUserPageSegmentView alloc] initWithFrame:CGRectMake(0.0, self.headerHeight, CGRectGetWidth(self.bounds), 44.0)];
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:self.segmentView];
        self.segmentView.segmentDelegate = self;
        self.segmentView.items = [NSMutableArray arrayWithArray:@[@"推荐", @"热门"]];
        
        _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _pageScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        _pageScrollView.scrollEnabled = YES;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.userInteractionEnabled = YES;
        _pageScrollView.exclusiveTouch = YES;
        _pageScrollView.tag = 102;
        _pageScrollView.delegate = self;
        [self.scrollView addSubview:_pageScrollView];
        
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView1.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView1.rowHeight = 120.0;
        _tableView1.scrollEnabled = NO;
        _tableView1.tag = 101;
        [self.pageScrollView addSubview:_tableView1];
        
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView2.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView2.rowHeight = 120.0;
        _tableView2.scrollEnabled = NO;
        _tableView2.tag = 103;
        [self.pageScrollView addSubview:_tableView2];
        
        _pageScrollView.frame = CGRectMake(0.0, self.headerHeight + 44.0, self.bounds.size.width, self.bounds.size.height);
        
        _tableView1.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
        
        _tableView2.frame = CGRectMake(self.bounds.size.width, 0.0, self.bounds.size.width, self.bounds.size.height);
        
        self.pageScrollView.contentSize = CGSizeMake(self.bounds.size.width*2, 0.0);

        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + self.headerHeight + 44.0);
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    _tableView1.delegate = delegate;
    _tableView1.dataSource = delegate;
    _tableView2.delegate = delegate;
    _tableView2.dataSource = delegate;
    _scrollView.delegate = delegate;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    NSLog(@"index:%ld",(long)index);
    NSLog(@"当前页码:%ld",index);
    [self.segmentView segmentChangedWithScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    NSLog(@"index:%ld",(long)index);
    NSLog(@"当前页码:%ld",index);
    [self.segmentView segmentChangedDidEndDecelerating:scrollView];
}

#pragma mark - INUserPageSegmentViewDelegate
- (void)segmentButtonDidAction:(NSInteger)segmentIndex {
    CGPoint contentOffset = CGPointMake(segmentIndex*CGRectGetWidth(self.scrollView.frame), 0.0);
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.pageScrollView setContentOffset:contentOffset animated:NO];
    } completion:^(BOOL finished) {
        [self.segmentView segmentChangedDidEndDecelerating:self.pageScrollView];
    }];
}

- (void)backButtonDidAction {
    CGPoint offset = CGPointMake(0.0, 0.0);
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.scrollView setContentOffset:offset animated:NO];
        [self.tableView1 setContentOffset:offset animated:NO];
        [self.tableView2 setContentOffset:offset animated:NO];
    } completion:^(BOOL finished) {
    }];
}

@end
