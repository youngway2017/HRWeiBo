//
//  HRMessageCenterViewController.m
//  HRWeibo
//
//  Created by yangwei on 15/11/29.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRMessageCenterViewController.h"
#import "Test1ViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface HRMessageCenterViewController ()

@end

@implementation HRMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(btnLeftClick:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
   
}

- (void)btnLeftClick:(UIButton *)sender {
    //    [self popViewControllerAnimated:YES];
    HRLog(@"message center leftclick!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Message %ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Test1ViewController *vc = [[Test1ViewController alloc] init];
    vc.title = @"Test1";
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
