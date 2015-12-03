//
//  UIWindow+Extenstion.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "UIWindow+Extenstion.h"
#import "NewFeatureViewController.h"
#import "HRTabBarController.h"
#import "NewFeatureTool.h"

@implementation UIWindow (Extenstion)

- (void)switchViewController {
    if([NewFeatureTool isShowNewFeature]) {
        NewFeatureViewController *newFeature = [[NewFeatureViewController alloc] init];
        self.rootViewController = newFeature;
    } else {
        HRTabBarController *tabController = [[HRTabBarController alloc] init];
        self.rootViewController = tabController;
    }

}


@end
