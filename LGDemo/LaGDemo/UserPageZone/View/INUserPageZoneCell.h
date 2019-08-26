//
//  INUserPageZoneCell.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"

@protocol INUserPageZoneCellDelegate;
@interface INUserPageZoneCell : UITableViewCell

@property (nonatomic, weak) id<INUserPageZoneCellDelegate> delegate;
@property (nonatomic, strong) NSString *showName;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) NSString *announcementText;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL showLine;

@end

@protocol INUserPageZoneCellDelegate <NSObject>


@end
