//
//  HRNavigationController.m
//  HRWeibo
//
//  Created by yangwei on 15/11/29.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface HRNavigationController ()

@end

@implementation HRNavigationController

+ (void)initialize {
    UIBarButtonItem *bar = [UIBarButtonItem appearance];
    
    //文字不可用
    NSMutableDictionary *dictDisabled = [NSMutableDictionary dictionary];
    [dictDisabled setObject:HRRgba(220, 220, 220,1) forKey:NSForegroundColorAttributeName];
    [dictDisabled setObject:NavButtonItemFont forKey:NSFontAttributeName];
    [bar setTitleTextAttributes:dictDisabled forState:UIControlStateDisabled];
    
    //文字正常颜色
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    [dictNormal setObject:HRRgba(255, 130, 0,1) forKey:NSForegroundColorAttributeName];
    [dictNormal setObject:NavButtonItemFont forKey:NSFontAttributeName];
    [bar setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if(self.childViewControllers.count > 0 ) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Image:@"navigationbar_back" imageHighlighted:@"navigationbar_back_highlighted"  action:@selector(btnLeftClick:)];

        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Image:@"navigationbar_more" imageHighlighted:@"navigationbar_more_highlighted"  action:@selector(btnRightClick:)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)btnLeftClick:(UIButton *)sender {
    [self popViewControllerAnimated:YES];
}

- (void)btnRightClick:(UIButton *)sender {
    [self popToRootViewControllerAnimated:YES];
}



@end
