//
//  Test2ViewController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/11/30.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "Test2ViewController.h"
#import "Test3ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Test3ViewController *vc = [[Test3ViewController alloc] init];
    vc.title = @"Test3";
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
