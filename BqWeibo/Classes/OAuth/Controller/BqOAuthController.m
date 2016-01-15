//
//  BqOAuthController.m
//  BqWeibo
//
//  Created by LinBq on 16/1/10.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqOAuthController.h"
#import "AFNetworking.h"
#import "BqAccount.h"
#import "MBProgressHUD+Bq.h"
#import "BqAccountTools.h"
#import "BqTabBarController.h"

// 遵守 UIWebView 的代理方法监听 访问状态
@interface BqOAuthController ()<UIWebViewDelegate>

@end

@implementation BqOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建一个一个 webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    /// 设置 web view 的代理
    webView.delegate = self;
    
    // 2. 用 webView 加载新浪提供的登录页面
    // 请求地址：https://api.weibo.com/oauth2/authorize
    // 请求参数：
    //      client_id：申请应用时分配的AppKey。
    //      redirect_uri：授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    NSString *client_idStr = @"3368077347";
    NSString *redirect_uriStr = @"http://";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", client_idStr, redirect_uriStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


#pragma mark - web view 代理方法实现
/// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    BqLog(@"webViewDidStartLoad - 开始加载");
    // #优化# 在加载时显示 MBProgressHUD 的菊花视图
    [MBProgressHUD showMessage:@"载入中…"];
}

/// 加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    BqLog(@"webViewDidFinishLoad - 加载完毕");
    // #优化# 加载完成后去除菊花视图
    [MBProgressHUD hideHUD];
}

/// 加载失败时调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    BqLog(@"load error - %@", error);
    // #优化# 当授权最后不加载回调页面时，隐藏菊花视图
    [MBProgressHUD hideHUD];
}

/// 监听请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    BqLog(@"request: %@", request.URL.absoluteString);
    
    // 1. 获得 URL
    NSString *urlStr = request.URL.absoluteString;
    
    // 2. 判断请求是否为回调地址，对其进行拦截
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {    // 是回调地址
        // 2.1. 截取 code 参数
        int fromIndex = range.location + range.length;
        NSString *codeStr = [urlStr substringFromIndex:fromIndex];
//        BqLog(@"code: %@", codeStr);
        // 2.2. 利用 code 参数换取 accessToken
        [self accessTokenWithCode:codeStr];
        // 2.3. 禁止加载回调地址
        return NO;
    }
    return YES;
}

#pragma mark - 方法抽取
/// 利用 code 参数换取 accessToken
/*
 URL: https://api.weibo.com/oauth2/access_token
 请求参数：
 client_id: 3368077347
 client_secret: 72fcc6acfc5e951f2e49eca2317feaa6
 redirect_uri: http://
 grant_type: authorization_code
 code: d42fda6e8baf0f86ea65a2fe4480619f
 */
- (void)accessTokenWithCode:(NSString *)codeStr{
    // 1. 请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3368077347";
    params[@"client_secret"] = @"72fcc6acfc5e951f2e49eca2317feaa6";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = codeStr;
    
    // 3. 发送请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation,  NSDictionary *responseObject) {
        // #归档# 将返回的账号数据存储到沙盒的 Document 中
//        [responseObject writeToFile:path atomically:YES];
        // 存储账号信息，以字典方式获取，以 archive 方式存储
        BqAccount *account = [BqAccount accountWithDict:responseObject];
        [BqAccountTools saveAccount:account];
        
//        BqLog(@"request  succeed - %@", responseObject);
        
        // #切控制器# 授权完成后，切换根控制器到主界面
        [[UIApplication sharedApplication] keyWindow].rootViewController = [[BqTabBarController alloc] init];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BqLog(@"request failed - %@", error);
    }];
}


- (void)dealloc{
    BqLog(@"OAuth controller is dead.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
