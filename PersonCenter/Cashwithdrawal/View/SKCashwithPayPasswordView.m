//
//  SKCashwithPayPasswordView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/2/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKCashwithPayPasswordView.h"

@interface SKCashwithPayPasswordView ()<UITextFieldDelegate>
{
     NSMutableString *_mutString;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@end

@implementation SKCashwithPayPasswordView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [UIColor hexStringToColor:@"B9C0C6"].CGColor;
    _passwordTF.delegate = self;
}
#pragma mark --> xib加载密码框视图
+ (SKCashwithPayPasswordView *)instanceSKPasswordView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKCashwithPayPasswordView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
#pragma mark --> 密码框展示
- (void)show
{
   [_passwordTF becomeFirstResponder];
}
#pragma mark --> 忘记密码
- (IBAction)forgetPassword:(UIButton *)sender {
     [self removeFromSuperview];
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(getpassWord:)]) {
        [_vDelegate getpassWord:@"Y"];
    }
}
#pragma mark --> 关闭输入框
- (IBAction)CloseBtnClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(getpassWord:)]) {
        [self removeFromSuperview];
        [_vDelegate getpassWord:_passwordTF.text];
    }
    [self removeFromSuperview];
}
#pragma mark --> 数字键盘点击事件的响应
- (IBAction)numValueChangeClick:(UIButton *)sender {
    
    if (sender.tag < 30) {
    [_mutString appendFormat:@"%@", sender.currentTitle];
    }else if (sender.tag == 30){
    if (_mutString.length >= 1) {
    NSRange deleteRange = { [_mutString length] - 1, 1 };
    [_mutString deleteCharactersInRange:deleteRange];
    }
    }else{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(getpassWord:)]) {
    if (_mutString.length > 1) {
    [self removeFromSuperview];
    [_vDelegate getpassWord:_mutString];
    }
    }
    }
//_passwordText.text = _mutString;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     if (_vDelegate && [_vDelegate respondsToSelector:@selector(getpassWord:)]) {
     [self removeFromSuperview];
     [_vDelegate getpassWord:textField.text];
     }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self endEditing:YES];
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
