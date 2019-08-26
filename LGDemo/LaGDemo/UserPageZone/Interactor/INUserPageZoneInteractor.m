//
//  INUserPageZoneInteractor.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import "INUserPageZoneInteractor.h"

@implementation INUserPageZoneInteractor

#pragma mark - SETTER/GETTER
- (INUserPageZoneConfig *)teamAnnounceConfig {
    if (!_teamAnnounceConfig) {
        _teamAnnounceConfig = [[INUserPageZoneConfig alloc] init];
    }
    return _teamAnnounceConfig;
}

@end
