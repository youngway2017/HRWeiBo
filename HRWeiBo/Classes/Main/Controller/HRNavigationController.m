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
