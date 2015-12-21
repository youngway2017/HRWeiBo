//
//  HRProfileViewController.m
//  HRWeibo
//
//  Created by yangwei on 15/11/29.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRProfileViewController.h"
#import "Test1ViewController.h"
#import "HRArrowItem.h"
#import "HRSettingGroup.h"
#import "SDImageCache.h"

@interface HRProfileViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) HRArrowItem *cache;
@end

@implementation HRProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(btnLeftClick:)];
    [self addGroup01];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    double cacheSize = size / 1000.0 / 1000.0;
    self.cache.subTitle = [NSString stringWithFormat:@"%.1fMB",cacheSize];
    [self.tableView reloadData];
}

- (void)addGroup01 {
    HRArrowItem *cache = [HRArrowItem arrowItemWithIcon:@"" title:@"清除缓存" descVC:nil];
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    double cacheSize = size / 1000.0 / 1000.0;
    cache.option = ^ (HRSettingItem *cache){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认清除缓存？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    
    cache.subTitle = [NSString stringWithFormat:@"%.1fMB",cacheSize];
    self.cache = cache;
    HRSettingGroup *group1 = [[HRSettingGroup alloc] init];
    NSMutableArray *items = [NSMutableArray array];
    
    [items addObject:cache];
    
    group1.items = items;
    [self.settingGroups addObject:group1];
}


- (void)btnLeftClick:(UIButton *)sender {
    HRLog(@"profile leftclick!");
    Test1ViewController *vc = [[Test1ViewController alloc] init];
    vc.title = @"Test1";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            [[SDImageCache sharedImageCache] clearDisk];
            self.cache.subTitle = @"0.0MB";
            [self.tableView reloadData];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
