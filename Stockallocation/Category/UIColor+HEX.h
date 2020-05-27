//
//  UIColor+HEX.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)

+ (UIColor *)colorWithHex:(UInt32)hex;

+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
#pragma mark --> 16进制设置颜色（html）字符串转为UIcolor 可以设置透明度
+ (UIColor *)colorWithHexString:(NSString *)hexString
                       andAlpha:(CGFloat)alpha;

- (NSString *)HEXString;

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *)hexStringToColor: (NSString *)stringToConvert;

+(UIColor *)HxIsWaterBlueColor;

@end
