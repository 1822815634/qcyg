//
//  SYPasswordView.m
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "SYPasswordView.h"
#import "PGNumberKeyboard.h"
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height self.frame.size.height  //每一个输入框的高度等于当前view的高度
@interface SYPasswordView ()<PGNumberKeyboardDelegate , UITextFieldDelegate>
{
    PGNumberKeyboard *_keyboard;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点

@end

@implementation SYPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor;
        [self initPwdTextField];
    }
    return self;
}

- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = self.frame.size.width / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, 0, 1, K_Field_Height)];
        lineView.backgroundColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        [self addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    textField.userInteractionEnabled = YES;
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, K_Field_Height)];
        _textField.layer.borderColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1].CGColor;
        _textField.layer.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:247/255.0 alpha:1].CGColor;
        //输入的文字颜色为白色
        _textField.textColor = [UIColor clearColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor clearColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _keyboard = [[PGNumberKeyboard alloc]initWithTextField:_textField];
        _keyboard.delegate = self;
        _textField.inputView = _keyboard;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
      [self.textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addSubview:_textField];
    }
    return _textField;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"] && object == self.textField) {
//        NSLog(@"textField - 输入框内容改变,当前内容为: %@",self.textField.text);
        self.textField.userInteractionEnabled = YES;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)editChanage:(id)sender
{
    if ([sender isKindOfClass:[UITextField class]]) {
        self.textField.userInteractionEnabled = YES;
        if (self.textField.text.length > 6) {
            self.textField.userInteractionEnabled = NO;
            return;
        }
        for (UIView *dotView in self.dotArray) {
            dotView.hidden = YES;
        }
        for (int i = 0; i < self.textField.text.length; i++) {
            ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
        }
        if (self.textField.text.length == kDotCount) {
           NSLog(@"确认 %@",self.textField.text);
        }
    }
}
- (void)sureClick
{
    NSString *password = self.textField.text;
    if (password.length > 6) {
      password = [self.textField.text substringToIndex:6];
    }
    if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(passwordSure:)]) {
        [_Vdelegate passwordSure:password];
    }
}
-(void)dealloc{
    NSLog(@"%s",__func__);
    [self.textField removeObserver:self forKeyPath:@"text" context:nil];
}
@end
