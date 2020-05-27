//
//  SKForgetPasswordViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKForgetPasswordViewController.h"
#import "UIButton+CountDown.h"
#import "ToolClass.h"
#import "NSString+Others.h"
@interface SKForgetPasswordViewController ()<UITextFieldDelegate>
{
    NSString *_registertoken;
}
@property (nonatomic , weak)UIView *bgView;
@property (nonatomic , weak)UITextField *nickTF;
@property (nonatomic , weak)UITextField *cardNumTF;
@property (nonatomic , weak)UIButton *sureButton;
@property (nonatomic , weak)UIButton *getCodeBtn;
@property (nonatomic , weak)UITextField *passwdTF;
@end

@implementation SKForgetPasswordViewController
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view).offset(0);
            make.top.equalTo(weakSelf.view.mas_top).offset(10);
            make.height.equalTo(@(182));
        }];
        _bgView = view;
    }
    return _bgView;
}
- (UITextField *)nickTF
{
    if (!_nickTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入手机号";
        tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        tf.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-100);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
            make.height.equalTo(@(20));
        }];
        _nickTF = tf;
    }
    return _nickTF;
}
- (UITextField *)cardNumTF
{
    if (!_cardNumTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入验证码";
        tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        tf.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-110);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(81);
            make.height.equalTo(@(20));
        }];
        _cardNumTF = tf;
    }
    return _cardNumTF;
}
- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"获取验证码" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = kFont(15);
        button.layer.backgroundColor = [UIColor hexStringToColor:@"#4062f4"].CGColor;
        [button addTarget:self action:@selector(getcodeNum) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.cardNumTF.mas_right).offset(15);
            make.right.equalTo(weakSelf.view.mas_right).offset(-5);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(73.5);
            make.height.equalTo(@(35));
        }];
        _getCodeBtn = button;
    }
    return _getCodeBtn;
}
- (UITextField *)passwdTF
{
    if (!_passwdTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入密码";
        tf.font = kFont(17);
        tf.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-110);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(142);
            make.height.equalTo(@(20));
        }];
        _passwdTF = tf;
    }
    return _passwdTF;
}
- (UIButton *)sureButton
{
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即修改" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        button.layer.backgroundColor = [UIColor hexStringToColor:@"#4062f4"].CGColor;
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 22.5;
        [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(13);
            make.right.equalTo(weakSelf.view.mas_right).offset(-13);
            make.top.equalTo(weakSelf.bgView.mas_bottom).offset(25);
            make.height.equalTo(@(45));
        }];
        _sureButton = button;
    }
    return _sureButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addnickLab];
    [self nickTF];
    [self getCodeBtn];
    [self passwdTF];
    [self sureButton];
}
- (void)addnickLab
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"手机号";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    WS(weakSelf);
    [weakSelf.bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(72));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(0);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(60);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"验证码";
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label2.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label2.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(81);
        make.height.equalTo(@(20));
        make.width.equalTo(@(72));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(0);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(121);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"密  码";
    label3.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label3.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label3.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(142);
        make.height.equalTo(@(20));
        make.width.equalTo(@(72));
    }];
}
#pragma mark --> 验证电话号码格式
- (BOOL)checkphoneNumber
{
    if ([self.nickTF.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        [self.view toastShow:@"请填写手机号码"];
        return NO;
    }else if (![ToolClass  isMobileNumber:self.nickTF.text]) {
        [self.view endEditing:YES];
        [self.view toastShow:@"手机号码错误，请重新输入"];
        return NO;
    }else if ([self.nickTF.text length] < 11 ||[self.nickTF.text length] > 11 ) {
        [self.view endEditing:YES];
        [self.view toastShow:@"请核对手机号码"];
        return NO;
    }else{
        [self.view endEditing:YES];
        return YES;
    }
}
- (void)getcodeNum
{
    WS(weakSelf);
    if (![self checkphoneNumber]) {
        return;
    }else{
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a = [date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
        NSString *rippString = [NSString stringWithFormat:@"%@%@%@",@"wepladg235gvf9h4o5rm342asd",_nickTF.text,timeString];
        NSString *ncrypted = [NSString md5HexDigest:rippString];
        NSDictionary *parasmeter = @{@"mobile":_nickTF.text,@"time":timeString,@"encrypted":ncrypted};
        [SVCCommunityApi registerTokenWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                [weakSelf.getCodeBtn startWithSeconds:60];
                _registertoken = [JSON objectForKey:@"passtoken"];
            }else{
                [weakSelf.view toastShow:msg];
            }
        } andfail:^(NSError *error) {
            [weakSelf.view toastShow:netFailString];
        } path:@"applyPassword"];
    }
}
- (void)sureClick
{
    if ([self checkphoneNumber]) {
        if (self.passwdTF.text.length >= 6 && self.cardNumTF.text.length > 2) {
            NSDictionary *params = @{@"token":_registertoken,@"newpassword":self.passwdTF.text,@"mobile":self.nickTF.text,@"smscode":self.cardNumTF.text};
            WS(weakSelf);
            [SVCCommunityApi passwordChangeWithNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
                [weakSelf.view toastShow:msg];
                if (code == 0) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } andfail:^(NSError *error) {
                [weakSelf.view toastShow:netFailString];
            }];
        }else{
            [self.view toastShow:@"请检查您的输入信息"];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
