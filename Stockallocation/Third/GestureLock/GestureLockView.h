//
//  GestureLockView.h
//  AlipayLock
//
//  Created by houji007 on 15/10/23.
//  Copyright © 2015年 houji007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureLockView : UIView
@property(nonatomic,copy)void(^unlockSuccess)();

@property(nonatomic,copy)void(^setSuccess)();
//忘记手势密码的回调
@property(nonatomic,copy)void(^btnBlock)();

//是否隐藏底部按钮 底部按钮的tag值 0 忘记手势密码 1跳过 暂不设置
-(instancetype)initWithFrame:(CGRect)frame hiddenBottom:(BOOL)hidden bottomBtnTag:(int)tag;

- (void)reSetPassWord;
@end
