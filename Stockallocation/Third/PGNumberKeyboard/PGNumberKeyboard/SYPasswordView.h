//
//  SYPasswordView.h
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYPasswordViewDelegate <NSObject>
@optional
- (void)passwordSure:(NSString *)password;
@end

@interface SYPasswordView : UIView<UITextFieldDelegate>

/**
 *  清除密码
 */
- (void)clearUpPassword;


@property (nonatomic, weak) id<SYPasswordViewDelegate> Vdelegate;

@end
