//
//  NSString+Extension.h
//  
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
//- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (NSString *) throwExceptionString;

//不区分大小写是否包含某个字符
- (BOOL)containsStringWith:(NSString *)str;

//判断某个字符串包含某些特殊字符开头的，不区分大小写
- (BOOL)hasStringWithPrefix:(NSString *)aString;

//时间戳返回时间
+ (NSString*)getOvertime:(NSString*)mStr;

@end
