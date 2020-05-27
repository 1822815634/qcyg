//
//  XMThireWebViewController.m
//  WYCD
//
//  Created by xumin on 2018/9/10.
//  Copyright © 2018年 WYCD. All rights reserved.
//

#import "XMThireWebViewController.h"
#import "WSProgressHUD.h"
#import <WebKit/WebKit.h>


#define POST_JS @"function my_post(path, params) {\
var method = \"POST\";\
var utf = \"UTF-8\";\
var form = document.createElement(\"form\");\
form.setAttribute(\"method\", method);\
form.setAttribute(\"accept-charset\", utf);\
form.setAttribute(\"action\", path);\
for(var key in params){\
if (params.hasOwnProperty(key)) {\
var hiddenFild = document.createElement(\"input\");\
hiddenFild.setAttribute(\"type\", \"hidden\");\
hiddenFild.setAttribute(\"name\", key);\
hiddenFild.setAttribute(\"value\", params[key]);\
}\
form.appendChild(hiddenFild);\
}\
document.body.appendChild(form);\
form.submit();\
}"

@interface XMThireWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate,WKScriptMessageHandler>

@property (nonatomic,weak) WKWebView *webView;

@end

@implementation XMThireWebViewController
- (WKWebView *)webView
{
    if (!_webView) {
           NSString *javaScriptSource = @"";
        WKUserScript *script = [[WKUserScript alloc]initWithSource:javaScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.userContentController = [[WKUserContentController alloc]init];
        [config.userContentController addUserScript:script];
        WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Knavheight) configuration:config];
        web.allowsBackForwardNavigationGestures = YES;
        web.navigationDelegate = self;
        web.UIDelegate = self;
        web.scrollView.delegate = self;
        [self.view addSubview:web];
        _webView = web;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMianUI];
}

-(void)setMianUI{
    NSString *dataStr = [NSString stringWithFormat:@"{\"token\":\"%@\",\"order_amt\":\"%@\",\"username\":\"%@\",\"bankcard\":\"%@\",\"cert_no\":\"%@\"}",self.prameStr,self.order_am,self.username,self.bankcard,self.cert_no];
    NSString * url = self.httpStr;
    NSString * js = [NSString stringWithFormat:@"%@my_post(\"%@\", %@)",POST_JS,url,dataStr];    // 执行JS代码
  [self.webView evaluateJavaScript:js completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{

}

/** 网页加载完成 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [WSProgressHUD dismiss];
}
/** 有JS中alert打印的时候会走这个方法 */
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%@",message);
    if (completionHandler) {
        completionHandler();
    }
}
/** 接收JS中方法执行事件。 */
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"=======%@",message.name);
    [self JCtoOC:message];
}
-(void)JCtoOC:(id)body{
    //保存开通的信息
//    [[WYUserPwdManager sharedManager] wy_saveBankOpenMessage:@"openSuccess"];
//    [self.navigationController popToRootViewControllerAnimated:YES];
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
