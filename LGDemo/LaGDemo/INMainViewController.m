//
//  INMainViewController.m
//  LaGDemo
//
//  Created by Dface on 2019/8/26.
//  Copyright © 2019 com.boliboli. All rights reserved.
//

#import "INMainViewController.h"
#import "INUserPageZoneViewController.h"

@interface INMainViewController ()

@end

@implementation INMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *demoButton;
    demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    demoButton.frame = CGRectMake(50, 370, 88, 44);
    demoButton.layer.cornerRadius = 4;
    demoButton.backgroundColor = [UIColor brownColor];
    [demoButton setTitle:@"拉勾APP首页示例" forState:UIControlStateNormal];
    [demoButton addTarget:self action:@selector(demoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:demoButton];
}

- (void)demoButtonClick {
    INUserPageZoneViewController *pageVC = [[INUserPageZoneViewController alloc] init];
    [self.navigationController pushViewController:pageVC animated:YES];
}

@end
