//
//  INUserPageZoneConfig.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import "INUserPageZoneConfig.h"

@implementation INUserPageZoneConfig

#pragma mark - SETTER/GETTER
- (NSMutableArray *)groupDatasources {
    if (!_groupDatasources) {
        _groupDatasources = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger index = 0; index < 10; index ++) {
            INUserPageZoneModel *model = [[INUserPageZoneModel alloc] init];
            model.showName = @"你的名字";
            model.avatarUrl = @"http://g.hiphotos.baidu.com/image/pic/item/0b46f21fbe096b6340b5e86c01338744ebf8ac5a.jpg";
            model.timeString = @"2019/08/01 13:51";
            model.announcementText = @"Today,I consider myself the luckiest man on the face of the earth.";
            [_groupDatasources addObject:model];
        }
    }
    return _groupDatasources;
}

@end
