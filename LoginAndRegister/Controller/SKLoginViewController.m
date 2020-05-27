//
//  SKLoginViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/28.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKLoginViewController.h"
#import "SKForgetPasswordViewController.h"
#import "SKRegisterViewController.h"
#import "ToolClass.h"
#import "GestureLockView.h"
#import "NSString+Others.h"
#import "UIButton+CountDown.h"
@interface SKLoginViewController ()<UITextFieldDelegate>
@property (nonatomic , weak)UIView *bgView;
@property (nonatomic , weak)UITextField *nickTF;
@property (nonatomic , weak)UITextField *cardNumTF;
@property (nonatomic , weak)UITextField *testNumTF;
@property (nonatomic , weak)UIButton *sureButton;
@property (nonatomic , weak)UIButton *forgetPasswordButton;
@property (nonatomic , weak)UIButton *registerButton;
@property (nonatomic , weak)UIImageView *topImagell;
@property (nonatomic , weak)UIButton *getCodeBtn;

@end

@implementation SKLoginViewController
- (UIImageView *)topImagell
{
    if (!_topImagell) {
        UIImageView *imagell = [[UIImageView alloc] init];
        [self.view addSubview:imagell];
        WS(weakSelf);
        imagell.contentMode = UIViewContentModeScaleAspectFill;
        imagell.image = showImage(@"头图");
        [imagell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view).offset(0);
            make.top.equalTo(weakSelf.view.mas_top).offset(0);
            make.height.equalTo(@(165));
        }];
        _topImagell = imagell;
    }
    return _topImagell;
}
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view).offset(0);
            make.top.equalTo(weakSelf.topImagell.mas_bottom).offset(16);
            make.height.equalTo(@(181));
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
        tf.font = kFont(17);
        tf.textColor = BlackbgColor;
        tf.textAlignment = NSTextAlignmentLeft;
    tf.keyboardType = UIKeyboardTypeNumberPad;
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
        tf.placeholder = @"密码为6位至16位";
    tf.secureTextEntry = YES;
        tf.font = kFont(17);
        tf.textColor = BlackbgColor;
        tf.textAlignment = NSTextAlignmentLeft;
    tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-80);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(81);
            make.height.equalTo(@(20));
        }];
        _cardNumTF = tf;
    }
    return _cardNumTF;
}

- (UITextField *)testNumTF
{
    if (!_testNumTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入验证码";
        tf.font = kFont(17);
        tf.textColor = BlackbgColor;
        tf.textAlignment = NSTextAlignmentLeft;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-100);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(141);
            make.height.equalTo(@(20));
        }];
        _testNumTF = tf;
    }
    return _testNumTF;
}

- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"获取验证码" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = kFont(15);
        button.layer.backgroundColor = [UIColor hexStringToColor:@"4062f4"].CGColor;
        [button addTarget:self action:@selector(getcodeNum) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.testNumTF.mas_right).offset(5);
            make.right.equalTo(weakSelf.view.mas_right).offset(-5);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(133.5);
            make.height.equalTo(@(35));
        }];
        _getCodeBtn = button;
    }
    return _getCodeBtn;
}

- (UIButton *)sureButton
{
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"登录" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = kFont(17);
        button.layer.backgroundColor = KBlueColor.CGColor;
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 22.5;
        button.tag = 1;
        [button addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
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
- (UIButton *)forgetPasswordButton
{
    if (!_forgetPasswordButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"忘记密码" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
        button.titleLabel.font = kFont(14);
         button.tag = 2;
        [button addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(33);
            make.top.equalTo(weakSelf.sureButton.mas_bottom).offset(16);
            make.height.equalTo(@(30));
            make.width.equalTo(@(75));
        }];
        _forgetPasswordButton = button;
    }
    return _forgetPasswordButton;
}
- (UIButton *)registerButton
{
    if (!_registerButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即注册 >" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
        button.titleLabel.font = kFont(14);
         button.tag = 3;
        [button addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view.mas_right).offset(-33);
            make.top.equalTo(weakSelf.sureButton.mas_bottom).offset(16);
            make.height.equalTo(@(30));
            make.width.equalTo(@(75));
        }];
        _registerButton = button;
    }
    return _registerButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:KBlueColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]]; self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:kFont(18)};
    UIButton *leftCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftCustomButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftCustomButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
    [leftCustomButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateHighlighted];
    leftCustomButton.frame = CGRectMake(2, 5, 25, 32);
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftCustomButton];
    [self.navigationItem setLeftBarButtonItem:leftButtonItem];
        self.view.backgroundColor = [UIColor whiteColor];
    [self addnickLab];
    [self nickTF ];
//    self.nickTF.text = @"15356648976 ";
    [self cardNumTF];
//    self.cardNumTF.text = @"123456789";
    [self testNumTF];
    [self getCodeBtn];
    [self forgetPasswordButton];
    [self registerButton];
}
- (void)addnickLab
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"手机号";
    label.font = kFont(17);
    label.textColor = Color(63, 67, 79);
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
    label2.text = @"密码";
    label2.font = kFont(17);
    label2.textColor = Color(63, 67, 79);
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
    make.top.equalTo(label2.mas_bottom).offset(20);
    make.height.equalTo(@(1));
    }];
    
    
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"验证码";
    label3.font = kFont(17);
    label3.textColor = Color(63, 67, 79);
    label3.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(140);
        make.height.equalTo(@(20));
        make.width.equalTo(@(72));
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(0);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(180);
        make.height.equalTo(@(1));
    }];
    
}
- (void)sureClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            [self login];
            break;
        case 2:
            [self forgetPassword];
            break;
        case 3:
            [self registerVC];
            break;
        default:
            break;
    }
}
- (void)login{
    WS(weakSelf);
    if ([self checkphoneNumber]) {
        if (self.cardNumTF.text.length >= 6) {
            if ([self.testNumTF.text isEqualToString:@""]) {
                [self.view endEditing:YES];
                [self.view toastShow:@"请填写验证码"];
            } else {
                NSDictionary *parasmeter = @{@"account":self.nickTF.text,@"password":self.cardNumTF.text,@"sms_code":self.testNumTF.text};
                [SVCCommunityApi LoginWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
                    
                    if (code == 0) {
                        NSDictionary *dict = [JSON objectForKey:@"userinfo"];
                        SKUserInfoModel *model = [SKUserInfoModel modelWithDict:dict];
                        [model saveUserModel];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:nil];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        [[NSUserDefaults standardUserDefaults]setObject:self.nickTF.text forKey:@"phone"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        /**
                         添加手势密码
                         */
                        GestureLockView * lock=[[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) hiddenBottom:NO bottomBtnTag:1];
                        lock.setSuccess = ^{
                            [lock removeFromSuperview];
                            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:GestureTag];
                        };
                        [[UIApplication sharedApplication].keyWindow addSubview:lock];
                    }else {
                        [weakSelf.view toastShow:msg];
                    }
                } andfail:^(NSError *error) {
                    
                }];
            }
        }else{
            [weakSelf.view toastShow:@"请检查您的密码"];
        }
    }
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

- (void)getcodeNum {
    WS(weakSelf);
    if (![self checkphoneNumber]){
        
    }else {
        if (self.cardNumTF.text.length >= 6) {
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a = [date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
            NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
            NSString *rippString = [NSString stringWithFormat:@"%@%@%@",@"wepladg235gvf9h4o5rm342asd",_nickTF.text,timeString];
            NSString *ncrypted = [NSString md5HexDigest:rippString];
            NSDictionary *parasmeter = @{@"account":_nickTF.text,@"password":_cardNumTF.text, @"time":timeString,@"encrypted":ncrypted};
            [SVCCommunityApi loginCodeWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
                if (code == 0) {
                    [weakSelf.getCodeBtn startWithSeconds:60];
                    //                _registertoken = [JSON objectForKey:@"registertoken"];
                }else{
                    [weakSelf.view toastShow:msg];
                }
            } andfail:^(NSError *error) {
                [weakSelf.view toastShow:netFailString];
            } path:@"get_sms_code"];
        }else {
            [weakSelf.view toastShow:@"请输入密码"];
        }
    }
}

- (void)forgetPassword
{
    SKForgetPasswordViewController *forgetPasswordVC = [[SKForgetPasswordViewController alloc] init];
    forgetPasswordVC.title = @"忘记密码";
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}
- (void)registerVC
{
    SKRegisterViewController *registerVC = [[SKRegisterViewController alloc] init];
    registerVC.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
