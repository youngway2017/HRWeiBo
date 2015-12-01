//
//  HRDropdownMenu.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/1.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRDropdownMenu;
@protocol HRDropdownMenuDelegate <NSObject>

- (void)dropdownMenuDiddismiss:(HRDropdownMenu *)menu;

@end

@interface HRDropdownMenu : UIView


@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *contentController;
@property (nonatomic, weak) id<HRDropdownMenuDelegate> delegate;

+ (instancetype)menu;

- (void)showMenuFrom:(UIView *)from;

- (void)dismissMenu;

@end
