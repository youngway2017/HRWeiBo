//
//  Test1ViewController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/11/30.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    Test2ViewController *vc = [[Test2ViewController alloc] init];
    vc.title = @"Test2";
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
