//
//  INUserPageZonePresenter.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import "INUserPageZonePresenter.h"

@implementation INUserPageZonePresenter

#pragma mark TableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamAnnounceConfig.groupDatasources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"INUserPageZoneCell";
    INUserPageZoneCell *cell = (INUserPageZoneCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[INUserPageZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    INUserPageZoneModel *model = [self.teamAnnounceConfig.groupDatasources objectAtIndex:indexPath.row];
    
    cell.showName = model.showName;
    cell.avatarUrl = model.avatarUrl;
    cell.timeString = model.timeString;
    cell.announcementText = model.announcementText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == 100) {
        if (self.isLoading) {
            return;
        }
        
        self.isDraging = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 100) {
        // 底部scrollView
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat alpha = offsetY/self.teamAnnounceView.maxContentOffsetY;
        if (alpha > 0.5) {
            alpha = 0.5;
        }
        
        if (alpha < 0.0) {
            alpha = 0.0;
        }
        
        self.teamAnnounceView.contentBGView.alpha = alpha;
        if (offsetY >= self.teamAnnounceView.maxContentOffsetY) {
            self.teamAnnounceView.scrollView.scrollEnabled = NO;
            self.teamAnnounceView.contentBGView.backgroundColor = [UIColor whiteColor];
            self.teamAnnounceView.tableView1.scrollEnabled = YES;
            self.teamAnnounceView.tableView2.scrollEnabled = YES;
        } else {
            self.teamAnnounceView.scrollView.scrollEnabled = YES;
            self.teamAnnounceView.tableView1.scrollEnabled = NO;
            self.teamAnnounceView.tableView2.scrollEnabled = NO;
            self.teamAnnounceView.contentBGView.backgroundColor = [UIColor blackColor];
        }
        
        if (offsetY > self.teamAnnounceView.maxContentOffsetY) {
            [self.teamAnnounceView.scrollView setContentOffset:CGPointMake(0, self.teamAnnounceView.maxContentOffsetY) animated:NO];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 100) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 0) {
            if (offsetY > 100) {
                [UIView animateWithDuration:0.25 animations:^{
                    [self.teamAnnounceView.scrollView setContentOffset:CGPointMake(0, self.teamAnnounceView.maxContentOffsetY) animated:NO];
                } completion:^(BOOL finished) {
                }];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                    [self.teamAnnounceView.scrollView setContentOffset:CGPointMake(0, 0.0) animated:NO];
                } completion:^(BOOL finished) {
                }];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
}

#pragma mark - SETTER/GETTER
- (INUserPageZoneConfig *)teamAnnounceConfig {
    if (!_teamAnnounceConfig) {
        _teamAnnounceConfig = [[INUserPageZoneConfig alloc] init];
    }
    return _teamAnnounceConfig;
}

- (INUserPageZoneInteractor *)teamAnnounceInteractor {
    if (!_teamAnnounceInteractor) {
        _teamAnnounceInteractor = [[INUserPageZoneInteractor alloc] init];
    }
    return _teamAnnounceInteractor;
}

- (INUserPageZoneView *)teamAnnounceView {
    if (!_teamAnnounceView) {
        _teamAnnounceView = [[INUserPageZoneView alloc] initWithFrame:CGRectZero];
    }
    return _teamAnnounceView;
}

@end
