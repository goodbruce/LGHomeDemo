//
//  INUserPageZonePresenter.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INUserPageZoneView.h"
#import "INUserPageZoneCell.h"
#import "INUserPageZoneInteractor.h"

@interface INUserPageZonePresenter : NSObject

@property (nonatomic, strong) INUserPageZoneView *teamAnnounceView;
@property (nonatomic, strong) INUserPageZoneInteractor *teamAnnounceInteractor;
@property (nonatomic, strong) INUserPageZoneConfig *teamAnnounceConfig;

@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isDraging;

@end
