//
//  UIButton+CountDown.m
//  register
//
//  Created by 刘梓轩 on 2017/6/16.
//  Copyright © 2017年 MIKEz. All rights reserved.
//

#import "UIButton+CountDown.h"
#define kSendVerifyCode             @"验证码"
#define kResendVerifyCode(sec)      [NSString stringWithFormat:@"%ds", sec]
#define kColor(color)               [UIColor color]
#define kCGColor(color)             [UIColor color].CGColor

@implementation UIButton (CountDown)
- (void)startWithSeconds:(int)seconds {
    __block int timeout = seconds;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:kSendVerifyCode forState:UIControlStateNormal];
                self.layer.borderColor = BlackbgColor.CGColor;
                [self setUserInteractionEnabled:YES];
            });
        } else {
            int sec = timeout % (seconds + 1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:kResendVerifyCode(sec) forState:UIControlStateNormal];
                self.layer.borderColor = BlackbgColor.CGColor;
                [self setUserInteractionEnabled:NO];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
- (NSMutableAttributedString *)setMutableAttributedStringWithString:(NSString *)string color:(UIColor *)color range:(NSRange)range {
    return [self setMutableAttributedStringWithString:string color:color range:range subStrColor:nil subStrRange:NSMakeRange(0, 0)];
}
- (NSMutableAttributedString *)setMutableAttributedStringWithString:(NSString *)string color:(UIColor *)color range:(NSRange)range subStrColor:(UIColor *)subStrColor subStrRange:(NSRange)subStrRange {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
    if (subStrColor != nil && subStrRange.length != 0) {
        [attrString addAttribute:NSForegroundColorAttributeName value:subStrColor range:subStrRange];
    }
    return attrString;
}

@end
