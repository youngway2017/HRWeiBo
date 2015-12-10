//
//  HRComposeViewController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRComposeViewController.h"
#import "HRPlaceholderTextView.h"
#import "AccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface HRComposeViewController ()

@property (nonatomic, strong) HRPlaceholderTextView *textView;
@property (nonatomic, strong) HRAccount *account;

@end

@implementation HRComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    
    [self setTextView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (HRAccount *)account {
    return [AccountTool account];
}

#pragma mark - 设置导航栏
- (void)setNavigationItem {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    NSString *name = self.account ? self.account.nick_name : @"";
    NSString *title = @"发微博";
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.bounds = CGRectMake(0, 0, 200, 44);
    NSString *content = [NSString stringWithFormat:@"%@\n%@",title,name];
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *dictTitle = @{NSForegroundColorAttributeName:[UIColor orangeColor],
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    [attrs setAttributes:dictTitle range:[content rangeOfString:title]];
    
    NSDictionary *dictName = @{NSForegroundColorAttributeName:[UIColor blackColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:13]};
    [attrs setAttributes:dictName range:[content rangeOfString:name]];
    
    [titleLabel setAttributedText:attrs];
    self.navigationItem.titleView = titleLabel;
}

- (void)setTextView {
    self.textView = [[HRPlaceholderTextView alloc] init];
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.frame = self.view.bounds;
    self.textView.placeholder = @"分享新鲜事...";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
    [self.view addSubview:self.textView];
}
#pragma mark - 导航栏事件

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
//    https://api.weibo.com/2/statuses/update.json发送微博
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.account.access_token forKey:@"access_token" ];
    [dict setObject:self.textView.text forKey:@"status"];
    
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
