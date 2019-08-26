//
//  INUserPageHeaderView.m
//  AppDemo
//
//  Created by bruce on 2019/8/26.
//  Copyright © 2019 bruce. All rights reserved.
//

#import "INUserPageHeaderView.h"
#import "UIColor+Addition.h"

static CGFloat kHeaderPadding = 10.0;
static CGFloat kInfoHeight = 150.0;
static CGFloat kLabelHeight = 30.0;
static CGFloat kSignHeight = 40.0;
static CGFloat kMidPadding = 10.0;
static CGFloat kAvatarSize = 60.0;

static CGFloat kFollowBtnWidth = 60.0;
static CGFloat kFollowBtnHeight = 30.0;

@interface INUserPageHeaderView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *infoBGImageView;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *genderImageView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *signLabel;

@property (nonatomic, strong) UIButton *followButton;

@end

@implementation INUserPageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImageView];
        [self.backImageView addSubview:self.coverImageView];
        [self.backImageView addSubview:self.infoBGImageView];
        
        [self.backImageView addSubview:self.avatarImageView];
        
        [self.infoBGImageView addSubview:self.nameLabel];
        [self.infoBGImageView addSubview:self.genderImageView];
        [self.infoBGImageView addSubview:self.numberLabel];
        [self.infoBGImageView addSubview:self.signLabel];
        
        [self.infoBGImageView addSubview:self.followButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = self.bounds;
    self.coverImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.backImageView.frame), CGRectGetHeight(self.backImageView.frame) - kInfoHeight/2);
    
    self.infoBGImageView.frame = CGRectMake(0.0, CGRectGetHeight(self.backImageView.frame) - kInfoHeight - kHeaderPadding, CGRectGetWidth(self.backImageView.frame), kInfoHeight);
    
    self.avatarImageView.frame = CGRectMake(kHeaderPadding, CGRectGetHeight(self.backImageView.frame) - kInfoHeight - kHeaderPadding - kAvatarSize/2, kAvatarSize, kAvatarSize);
    
    CGFloat originY = kAvatarSize/2 + kMidPadding;
    CGFloat labelWidth = CGRectGetWidth(self.infoBGImageView.frame) - 2*kMidPadding;
    self.nameLabel.frame = CGRectMake(kMidPadding, originY, labelWidth, kLabelHeight);
    self.numberLabel.frame = CGRectMake(kMidPadding, CGRectGetMaxY(self.nameLabel.frame), labelWidth, kLabelHeight);
    
    self.signLabel.frame = CGRectMake(kMidPadding, CGRectGetMaxY(self.numberLabel.frame), labelWidth, kSignHeight);
    
    self.followButton.frame = CGRectMake(CGRectGetWidth(self.infoBGImageView.frame) - kFollowBtnWidth - kMidPadding, kMidPadding, kFollowBtnWidth, kFollowBtnHeight);
}


+ (CGFloat)headerHeight {
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    return screenWidth*0.65 + kInfoHeight;
}

#pragma mark - ACTIONS
- (void)followButtonAction {
    
}

#pragma mark - SETTER/GETTER
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _coverImageView.backgroundColor = [UIColor clearColor];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.image = [UIImage imageNamed:@"BeautyCar05.jpg"];
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}

- (UIImageView *)infoBGImageView {
    if (!_infoBGImageView) {
        _infoBGImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _infoBGImageView.backgroundColor = [UIColor whiteColor];
        _infoBGImageView.clipsToBounds = YES;
        _infoBGImageView.layer.cornerRadius = 2;
        _infoBGImageView.layer.masksToBounds = YES;
    }
    return _infoBGImageView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.backgroundColor = [UIColor clearColor];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.image = [UIImage imageNamed:@"p1393354_128k.jpg"];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = kAvatarSize/2;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UIImageView *)genderImageView {
    if (!_genderImageView) {
        _genderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _genderImageView.backgroundColor = [UIColor clearColor];
    }
    return _genderImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = [UIColor colorWithHexString:@"131619"];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"小鸥小欧";
    }
    return _nameLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.textColor = [UIColor colorWithHexString:@"585858"];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.text = @"2000粉丝 | 5关注";
    }
    return _numberLabel;
}

- (UILabel *)signLabel {
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _signLabel.font = [UIFont systemFontOfSize:12];
        _signLabel.textColor = [UIColor colorWithHexString:@"9a9b9c"];
        _signLabel.backgroundColor = [UIColor clearColor];
        _signLabel.textAlignment = NSTextAlignmentLeft;
        _signLabel.numberOfLines = 0;
        _signLabel.text = @"真正的友谊无论从正反看都应一样，不可能从前面看是蔷薇而从后面看是刺。";
    }
    return _signLabel;
}

- (UIButton *)followButton {
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.backgroundColor = [UIColor colorWithHexString:@"ff7e48"];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _followButton.layer.cornerRadius = kFollowBtnHeight/2;
        _followButton.layer.masksToBounds = YES;
        [_followButton addTarget:self action:@selector(followButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

@end
