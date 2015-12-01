//
//  HRTabBar.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/1.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRTabBar;
@protocol HRTabBarDelegate <NSObject>

- (void)tabBarDidClickAddBtn:(HRTabBar *)tabBar;

@end

@interface HRTabBar : UITabBar
@property (nonatomic, weak) id<HRTabBarDelegate> delegate;

+ (instancetype)tabBar;


@end
