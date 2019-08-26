//
//  INUserPageZoneViewController.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 bruce. All rights reserved.
//

#import "INUserPageZoneViewController.h"
#import "INUserPageZonePresenter.h"

@interface INUserPageZoneViewController ()

@property (nonatomic, strong) INUserPageZoneView *teamAnnounceView;
@property (nonatomic, strong) INUserPageZoneInteractor *teamAnnounceInteractor;
@property (nonatomic, strong) INUserPageZoneConfig *teamAnnounceConfig;
@property (nonatomic, strong) INUserPageZonePresenter *teamAnnouncePresenter;

@end

@implementation INUserPageZoneViewController

#pragma mark - loadView
- (void)loadView {
    [super loadView];
    self.view = self.teamAnnounceView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;

    [self configureAssociation];
    [self.teamAnnounceView.tableView1 reloadData];
    [self.teamAnnounceView.tableView2 reloadData];
}

#pragma mark - Configure
- (void)configureAssociation {
    //配置view
    self.teamAnnouncePresenter.teamAnnounceView = self.teamAnnounceView;
    
    self.teamAnnouncePresenter.controller = self;
    
    //presenter处理业务逻辑
    self.teamAnnounceView.delegate = self.teamAnnouncePresenter;
    
    //使用同一个配置
    self.teamAnnouncePresenter.teamAnnounceInteractor = self.teamAnnounceInteractor;
    self.teamAnnouncePresenter.teamAnnounceConfig = self.teamAnnounceInteractor.teamAnnounceConfig;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (INUserPageZonePresenter *)teamAnnouncePresenter {
    if (!_teamAnnouncePresenter) {
        _teamAnnouncePresenter = [[INUserPageZonePresenter alloc] init];
    }
    return _teamAnnouncePresenter;
}

- (INUserPageZoneView *)teamAnnounceView {
    if (!_teamAnnounceView) {
        _teamAnnounceView = [[INUserPageZoneView alloc] initWithFrame:CGRectZero];
    }
    return _teamAnnounceView;
}

@end
