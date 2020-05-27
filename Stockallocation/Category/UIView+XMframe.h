//
//  UIView+XMframe.h
//  baisi-one
//
//  Created by montnets on 16/8/31.
//  Copyright © 2016年 montnets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMframe)

/** 设置width */
@property (nonatomic,assign) CGFloat width;
/** 设置height */
@property (nonatomic,assign) CGFloat height;
/** 设置x */
@property (nonatomic,assign) CGFloat X;
 /** 设置y */
@property (nonatomic,assign) CGFloat Y;
/** 设置cneterX */
@property (nonatomic,assign) CGFloat centerX;
/** 设置centerY */
@property (nonatomic,assign) CGFloat centerY;
/** 设置size */
@property (nonatomic,assign) CGSize size;
/** 设置origin */
@property (assign, nonatomic) CGPoint tx_origin;
/** 设置center */
@property (assign, nonatomic) CGPoint tx_center;
/** 设置bottom */
@property (assign, nonatomic) CGFloat tx_bottom;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;


@end
