//
//  SKMainShowView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/6/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKMainShowView.h"

@interface SKMainShowView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintHeight;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation SKMainShowView

+ (SKMainShowView *)instanceSKMainShowView
{
   NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKMainShowView" owner:nil options:nil];
   return [nibView objectAtIndex:0];
}
- (IBAction)registerAndLoginClick:(UIButton *)sender {
       [self removeFromSuperview];
      if (_vDelegate && [_vDelegate respondsToSelector:@selector(registerAndLogin:)]) {
      [_vDelegate registerAndLogin:sender.tag];
      }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _registerBtn.clipsToBounds = YES;
    _registerBtn.layer.cornerRadius = 20;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"已有账号,去登陆"];
    [attrStr setAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                     range:NSMakeRange(6, 2)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,attrStr.length)];
    [_loginBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    if (kScreenWidth < 370) {
    _topConstraintHeight.constant = 3;
    }else{
    _topConstraintHeight.constant = 8;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
