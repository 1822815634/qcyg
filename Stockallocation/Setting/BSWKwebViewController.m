//
//  BSWKwebViewController.m
//  BankServer
//
//  Created by hxisWater on 2018/9/14.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "BSWKwebViewController.h"
#import <WebKit/WebKit.h>
@interface BSWKwebViewController ()<WKNavigationDelegate>
@property(nonatomic,weak)WKWebView* mainWeb;
@end

@implementation BSWKwebViewController
-(WKWebView*)mainWeb{
    if (!_mainWeb) {
       WKWebView *web= [[WKWebView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight - Knavheight)];
        web.backgroundColor = [UIColor whiteColor];
        web.navigationDelegate=self;
        [self.view addSubview:web];
        _mainWeb = web;
    }
    return _mainWeb;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [WSProgressHUD showWithStatus:@"加载中..."];
     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
     [self.mainWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // Do any additional setup after loading the view.
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"网页开始加载");
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
     [WSProgressHUD dismiss];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [WSProgressHUD dismiss];
//    NSLog(@"网页加载完成");
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
      [WSProgressHUD dismiss];
    [self.view toastShow:@"网页加载失败"];
//    NSLog(@"网页加载出错");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
      [WSProgressHUD dismiss];
    [self.view toastShow:@"网页加载失败"];
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
