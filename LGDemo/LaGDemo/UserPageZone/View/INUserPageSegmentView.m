//
//  INUserPageSegmentView.m
//  AppDemo
//
//  Created by bruce on 2019/8/26.
//  Copyright © 2019 bruce. All rights reserved.
//

#import "INUserPageSegmentView.h"
#import "UIColor+Addition.h"

static CGFloat kSegmentHeight = 44.0;
static CGFloat kLineWidth = 60.0;
static CGFloat kLineHeight = 1.0;
static CGFloat kTitleWidth = 60.0;

@interface INUserPageSegmentView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic) CGRect startLineRect;
@property (nonatomic) CGFloat lastOffsetX;

@end

@implementation INUserPageSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.startLineRect = CGRectZero;
        self.lastOffsetX = 0.0;
        [self addSubview:self.backImageView];
        [self addSubview:self.lineImageView];
        [self layoutContentSubViews];
        [self addSubview:self.backButton];
    }
    return self;
}

- (void)layoutContentSubViews {
    self.backImageView.frame = self.bounds;
    CGFloat titleHeight = CGRectGetHeight(self.backImageView.frame);
    
    UIView *lastView = nil;
    for (UIView *subView in self.backImageView.subviews) {
        subView.frame = CGRectMake(lastView?CGRectGetMaxX(lastView.frame):0.0, 0.0, kTitleWidth, titleHeight);
        lastView = subView;
    }
    
    self.lineImageView.frame = CGRectMake(0.0, titleHeight - kLineHeight, kLineWidth, kLineHeight);
    self.startLineRect = self.lineImageView.frame;
    
    self.backButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 44 - 10.0, 0.0, 44.0, 44.0);
}

- (void)setItems:(NSMutableArray *)items {
    _items = items;
    
    [self setupItemLabels];
}

- (void)setupItemLabels {
    for (NSInteger index = 0; index < self.items.count; index++) {
        NSString *title = [self.items objectAtIndex:index];
        UIButton *button = [self itemButton];
        [button setTitle:(title?title:@"") forState:UIControlStateNormal];
        button.tag = index;
        [self.backImageView addSubview:button];
        
        if (index == 0) {
            [button setTitleColor:[UIColor colorWithHexString:@"ff7e48"] forState:UIControlStateNormal];
        }
    }
    
    [self layoutContentSubViews];
}

- (void)segmentChangedWithScroll:(UIScrollView *)scrollView {
    NSLog(@"offset:%@",NSStringFromCGPoint(scrollView.contentOffset));
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    NSLog(@"index:%ld",(long)index);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    if (offsetX > scrollView.contentSize.width) {
        offsetX = scrollView.contentSize.width;
    }
    
    CGFloat offsetDistance = offsetX - self.lastOffsetX;
    
    CGFloat scale = offsetDistance/scrollView.frame.size.width;
    CGFloat disWidth = kTitleWidth*scale;
    
    NSInteger itemCount = self.items.count;
    
    if (disWidth >= 0) {
        CGFloat width = self.startLineRect.size.width + disWidth;
        if (width > itemCount*kLineWidth) {
            width = itemCount*kLineWidth;
        }
        CGRect lineFrame = self.lineImageView.frame;
        lineFrame.size.width = width;
        self.lineImageView.frame = lineFrame;
    } else {
        CGFloat width = self.startLineRect.size.width - disWidth;
        if (width < 0) {
            width = 0.0;
        }
        
        CGRect lineFrame = self.lineImageView.frame;
        lineFrame.size.width = width;
        lineFrame.origin.x = self.startLineRect.origin.x + disWidth;
        self.lineImageView.frame = lineFrame;
    }
}

- (void)segmentChangedDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.lastOffsetX = scrollView.contentOffset.x;
    
    CGRect lineFrame = self.lineImageView.frame;
    lineFrame.size.width = kLineWidth;
    lineFrame.origin.x = index*kLineWidth;
    
    for (UIButton *button in self.backImageView.subviews) {
        [button setTitleColor:[UIColor colorWithHexString:@"131619"] forState:UIControlStateNormal];
    }
    
    UIButton *currentButton = nil;
    for (UIButton *button in self.backImageView.subviews) {
        if (button.tag == index) {
            currentButton = button;
            break;
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineImageView.frame = lineFrame;
        [currentButton setTitleColor:[UIColor colorWithHexString:@"ff7e48"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.startLineRect = self.lineImageView.frame;
    }];
}

+ (CGFloat)segmentHeght {
    return kSegmentHeight;
}

#pragma mark - ACTIONS
- (void)buttonAction:(UIButton *)button {
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(segmentButtonDidAction:)]) {
        [self.segmentDelegate segmentButtonDidAction:button.tag];
    }
}

- (void)backButtonAction {
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(backButtonDidAction)]) {
        [self.segmentDelegate backButtonDidAction];
    }
}

#pragma mark - SETTER/GETTER
- (UIButton *)itemButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithHexString:@"131619"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"fe4373"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.backgroundColor = [UIColor whiteColor];
    }
    return _backImageView;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImageView.userInteractionEnabled = YES;
        _lineImageView.backgroundColor = [UIColor colorWithHexString:@"ff7e48"];
    }
    return _lineImageView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"ic_down_arrow"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _backButton.clipsToBounds = YES;
    }
    return _backButton;
}

@end
