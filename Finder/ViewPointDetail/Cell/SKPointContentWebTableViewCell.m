//
//  SKPointContentWebTableViewCell.m
//  Stockallocation
//
//  Created by wuyou on 2019/7/16.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKPointContentWebTableViewCell.h"

@interface SKPointContentWebTableViewCell () <UIWebViewDelegate>

@end

@implementation SKPointContentWebTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentWebView.scrollView.bounces = NO;
    self.contentWebView.frame = CGRectMake(0, 0, kScreenWidth, 200);
//    self.contentWebView.scrollView.scrollEnabled = NO;
    // Initialization code
}

- (void)setDataWithHtmlString:(NSString *)htmlString {
    self.contentWebView.delegate = self;
    [self.contentWebView loadHTMLString:htmlString baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //获取到webview的高度
//    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    webView.frame = CGRectMake(0,0, kScreenWidth, height+80);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
