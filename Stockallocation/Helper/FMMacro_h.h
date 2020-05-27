//
//  FMMacro_h.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/5/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#ifndef FMMacro_h_h
#define FMMacro_h_h
#import "UIImage+Others.h"
#import "SKUserInfoModel.h"
#import "UIView+XMframe.h"
#import "WSProgressHUD.h"
#import "SKBaseModel.h"
#import "SVCNavigationController.h"
#import "SKLoginViewController.h"
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kstatueHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define SystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kAppStatusBarHeight kstatueHeight + 44

#define iphoneX ([UIScreen mainScreen].bounds.size.height >= 812.0f)
#define  kTabbarHeight  (iphoneX ? (49.f+34.f) : 49.f)
#define Knavheight (iphoneX ? 88 : 64)
/** Bar 的高度*/
#define kSecrityHeight  ( iphoneX ?34:0 )
#define kFont(a) [UIFont fontWithName:@"PingFangSC-Regular" size:a]
#define NetWork4G @"NetWork4G"
#define NetWorkWifi @"NetWorkWifi"
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KredColor  [UIColor colorWithRed:244/255.0 green:60/255.0 blue:43/255.0 alpha:1]
#define KBlueColor [UIColor hexStringToColor:@"#4062f4"]
#define ktextColor [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1]
#define BtnbgColor   [UIColor hexStringToColor:@"#8490F6"]
#define BlackbgColor   [UIColor hexStringToColor:@"#3F434F"]
#define TableViewBGColor [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]
//弱引用
#define WS(weakSelf)  __weak __typeof(self)weakSelf = self;

#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define NSLog(...) printf("%s 第%d行: %s\n\n", [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#define NoNetAlertString @"网络状态不佳" //网络状态提示语
#define NoshowInfoString @"功能正在更新中，敬请期待!" //提示正在开发中
#define netFailString @"服务器出小差了，请重试" //服务器出小差了，请重试

#define showImage(image)[UIImage imageNamed:image]

//#define ServerUrl @"http://qcwy.ctxza.com/api/"

/*测试环境*/
//#define ServerUrl @"http://120.76.216.65/api/"
//#define ServerPath @"http://120.76.216.65"

/**正式环境*/
//#define ServerUrl @"http://www.qcygu.com/api/"
//#define ServerPath @"http://www.qcygu.com"

/**正式环境*/
#define ServerUrl @"https://www.qcygu.cn/api/"
#define ServerPath @"https://www.qcygu.cn"


#define HudeString @"hudeString"

#define GestureTag @"GestureTag" //是否开启密码锁定

#define GestureWord @"kPassword" //手势密码

//#define TOKEN @"a5a5a3ce-296f-4463-b76c-d338df046eef"   // 这个token 到时候要全文替换，切记


#endif /* FMMacro_h_h */
