//
//  INUserPageSegmentView.h
//  AppDemo
//
//  Created by bruce on 2019/8/26.
//  Copyright © 2019 bruce. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol INUserPageSegmentViewDelegate;
@interface INUserPageSegmentView : UIView

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) id<INUserPageSegmentViewDelegate>segmentDelegate;

- (void)segmentChangedWithScroll:(UIScrollView *)scrollView;

- (void)segmentChangedDidEndDecelerating:(UIScrollView *)scrollView;

+ (CGFloat)segmentHeght;

@end

@protocol INUserPageSegmentViewDelegate <NSObject>

- (void)segmentButtonDidAction:(NSInteger)segmentIndex;
- (void)backButtonDidAction;

@end
