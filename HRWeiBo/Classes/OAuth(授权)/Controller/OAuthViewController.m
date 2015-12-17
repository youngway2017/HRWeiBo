//
//  OAuthViewController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/2.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "OAuthViewController.h"
#import "NewFeatureTool.h"
#import "HRTabBarController.h"
#import "NewFeatureViewController.h"
#import "AccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2883928079&redirect_uri=http://www.baidu.com"];
//    client_id     true	string	申请应用时分配的AppKey。
//    redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在加载..."];
    HRLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
    HRLog(@"webViewDidFinishLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    HRLog(@"shouldStartLoadWithRequest-->%@",request.URL);
    NSString *url = [request.URL absoluteString];
    NSRange range = [url rangeOfString:@"code="];
    
    if(range.length) {
        NSString *code = [url substringFromIndex:(range.location +range.length)];
        [self getAccessTokenWithCode:code];
        return NO;
    }
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
    HRLog(@"didFailLoadWithError--%@",error);
}

#pragma mark - 根据返回的code获取access_token
//  https://api.weibo.com/oauth2/access_token
//  client_id       true	string	申请应用时分配的AppKey。
//  client_secret	true	string	申请应用时分配的AppSecret。
//  grant_type      true	string	请求的类型，填写authorization_code
//  grant_type为authorization_code时
//  必选	类型及范围	说明
//  code            true	string	调用authorize获得的code值。
//  redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

- (void)getAccessTokenWithCode:(NSString *)code {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"2883928079" forKey:@"client_id"];
    [dict setObject:@"47aab2954e040eeecd79252a2b0d7eea" forKey:@"client_secret"];
    [dict setObject:@"authorization_code" forKey:@"grant_type"];
    [dict setObject:code forKey:@"code"];
    [dict setObject:@"http://www.baidu.com" forKey:@"redirect_uri"];
    
    [HttpTool post:@"https://api.weibo.com/oauth2/access_token" parameters:dict success:^(id json) {
        NSLog(@"JSON: %@", json);
        HRAccount *account = [HRAccount accountWithDict:json];
        [AccountTool saveAccount:account];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [MBProgressHUD hideHUD];
        [window switchViewController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"Error: %@", error);
    }];
}
@end
