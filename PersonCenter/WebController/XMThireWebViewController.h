//
//  XMThireWebViewController.h
//  WYCD
//
//  Created by xumin on 2018/9/10.
//  Copyright © 2018年 WYCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMThireWebViewController : SKBaseViewController

/** 传过来的请求地HI */
@property (nonatomic,copy) NSString *httpStr;
/** 传过来的参数 */
@property (nonatomic,copy) NSString *prameStr;

@property (nonatomic , copy)NSString *order_am;

@property (nonatomic , copy)NSString *bankcard;

@property (nonatomic , copy)NSString *username;

@property (nonatomic , copy)NSString *cert_no;


@end
