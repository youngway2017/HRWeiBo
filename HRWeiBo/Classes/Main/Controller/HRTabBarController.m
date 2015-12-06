//
//  HRTabBarController.m
//  HRWeibo
//
//  Created by yangwei on 15/11/29.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRTabBarController.h"
#import "HRNavigationController.h"
#import "HRHomeViewController.h"
#import "HRMessageCenterViewController.h"
#import "HRDiscoverViewController.h"
#import "HRProfileViewController.h"
#import "HRTabBar.h"


@interface HRTabBarController ()<HRTabBarDelegate>

@end

@implementation HRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HRHomeViewController *homeController = [[HRHomeViewController alloc] init];
    HRNavigationController *navHome = [[HRNavigationController alloc] initWithRootViewController:homeController];
    homeController.navigationItem.title = @"首页";
    [self addViewController:navHome title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];

    
    HRMessageCenterViewController *messageCenterController = [[HRMessageCenterViewController alloc] init];
    HRNavigationController *navMessageCenter = [[HRNavigationController alloc] initWithRootViewController:messageCenterController];
    messageCenterController.navigationItem.title = @"消息";
    [self addViewController:navMessageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    
    HRDiscoverViewController *discoverController = [[HRDiscoverViewController alloc] init];
    HRNavigationController *navDiscover = [[HRNavigationController alloc] initWithRootViewController:discoverController];
    discoverController.navigationItem.title = @"发现";
    [self addViewController:navDiscover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    HRProfileViewController *profileController = [[HRProfileViewController alloc] init];
    HRNavigationController *navProfile = [[HRNavigationController alloc] initWithRootViewController:profileController];
    profileController.navigationItem.title = @"我";
    [self addViewController:navProfile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    HRTabBar *hrTabBar = [HRTabBar tabBar];
    [self setValue:hrTabBar forKeyPath:@"tabBar"];

}

- (void)addViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    
    //文字选中颜色
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    [dictSelected setObject:HRRgba(255, 130, 0,1) forKey:NSForegroundColorAttributeName];
    [vc.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    //文字正常颜色
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    [dictNormal setObject:HRRgba(123, 123, 123,1) forKey:NSForegroundColorAttributeName];
    [vc.tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    
    [vc.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:vc];
}

- (void)tabBarDidClickAddBtn:(HRTabBar *)tabBar {
    UIViewController *addVc = [[UIViewController alloc] init];
    addVc.view.backgroundColor = [UIColor blueColor];
    [self presentViewController:addVc animated:YES completion:nil];
}

@end
