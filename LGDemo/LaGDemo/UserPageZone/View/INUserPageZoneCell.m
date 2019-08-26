//
//  INUserPageZoneCell.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import "INUserPageZoneCell.h"
#import "UIColor+Addition.h"

static CGFloat kBGPadding = 10.0f;

static CGFloat kHorPadding = 15.0f;

static CGFloat kIconPadding = 15.0f;
static CGFloat kIconVPadding = 15.0f;

static CGFloat kHTitlePadding = 10.0f;
static CGFloat kVPadding = 10.0f;

static CGFloat kAvatarSize = 40.0f;

static CGFloat kVTitleHeight = 20.0f;
static CGFloat kVTimeHeight = 20.0f;

static CGFloat kVContentHeight = 30.0f;
static CGFloat kArrowSize = 15.0f;

@interface INUserPageZoneCell ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *textContentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation INUserPageZoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backImageView];
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.image = [UIImage imageNamed:@"ic_head_portrait"];
        _avatarImageView.layer.cornerRadius = kAvatarSize/2;
        _avatarImageView.layer.masksToBounds = YES;
        [self.backImageView addSubview:_avatarImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"606060"];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.backImageView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.backImageView addSubview:_timeLabel];
        
        _textContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textContentLabel.font = [UIFont systemFontOfSize:14];
        _textContentLabel.textColor = [UIColor colorWithHexString:@"606060"];
        _textContentLabel.backgroundColor = [UIColor clearColor];
        [self.backImageView addSubview:_textContentLabel];
        
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_arrowImageView setImage:[UIImage imageNamed:@"ic_more_arrow"]];
        //[self.backImageView addSubview:_arrowImageView];
        
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImageView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
        [self.backImageView addSubview:_lineImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kBGPadding);
    
    //CGFloat iconOriginX = self.iconImage?kHTitlePadding:0.0;
    //CGFloat iconSize = self.iconImage?kProfileIconSize:0.0;
    
    CGFloat iconOriginX = kIconPadding;
    CGFloat avatarSize = kAvatarSize;
    
    self.avatarImageView.frame = CGRectMake(iconOriginX, kIconVPadding, avatarSize, avatarSize);
    
    CGFloat contentWidth = CGRectGetWidth(self.backImageView.frame)-(3*kHTitlePadding+kArrowSize);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+kHTitlePadding, kIconVPadding, contentWidth, kVTitleHeight);
    
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+kHTitlePadding, CGRectGetMaxY(self.titleLabel.frame), contentWidth, kVTimeHeight);
    
    self.textContentLabel.frame = CGRectMake(kHorPadding, CGRectGetMaxY(self.avatarImageView.frame) + kVPadding, CGRectGetWidth(self.backImageView.frame) - 2*kHorPadding, kVContentHeight);
    
    self.arrowImageView.frame = CGRectMake(CGRectGetMaxX(self.backImageView.frame)-kArrowSize-kHTitlePadding, (CGRectGetHeight(self.backImageView.frame)-kArrowSize)/2, kArrowSize, kArrowSize);
    
    self.lineImageView.frame = CGRectMake(kHTitlePadding, CGRectGetHeight(self.backImageView.frame)-1.0, CGRectGetWidth(self.backImageView.frame)-kHTitlePadding, 1.0);
}

- (void)setShowName:(NSString *)showName {
    _showName = showName;
    self.titleLabel.text = (showName?showName:@"");
    [self setNeedsLayout];
}

- (void)setAnnouncementText:(NSString *)announcementText  {
    _announcementText = announcementText;
    self.textContentLabel.text = (announcementText?announcementText:@"");
    [self setNeedsLayout];
}

- (void)setTimeString:(NSString *)timeString {
    _timeString = timeString;
    self.timeLabel.text = (timeString?timeString:@"");
    [self setNeedsLayout];
}

- (void)setAvatarUrl:(NSString *)avatarUrl {
    _avatarUrl = avatarUrl;
    //self.avatarImageView.image = iconImage;
    if (_avatarUrl && _avatarUrl.length > 0) {
        NSRange range = [_avatarUrl rangeOfString:@"file://" options:NSCaseInsensitiveSearch];
        self.avatarImageView.image = nil;
        if (NSNotFound != range.location) {
            NSString *imageName = [_avatarUrl substringFromIndex:(range.location + range.length)];
            self.avatarImageView.image = [UIImage imageNamed:imageName];
            [self setNeedsLayout];
            return;
        }
    }
    
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    } else {
        self.backImageView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dealloc {
    
}

@end
