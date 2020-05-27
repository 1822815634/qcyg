//
//  SKRegisterViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/28.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRegisterViewController.h"
#import "ToolClass.h"
#import "NSString+Others.h"
#import "UIButton+CountDown.h"
#import "GestureLockView.h"
#import "BSWKwebViewController.h"
@interface SKRegisterViewController ()<UITextFieldDelegate>
{
    NSString *_registertoken;
}
@property (nonatomic , weak)UIView *bgView;
@property (nonatomic , weak)UITextField *nickTF;
@property (nonatomic , weak)UITextField *cardNumTF;
@property (nonatomic , weak)UITextField *passwordTF;
@property (nonatomic , weak)UITextField *RecommenderTF;
@property (nonatomic , weak)UIButton *protocolBtn;
@property (nonatomic , weak)UIButton *protocolSelectBtn;
@property (nonatomic , weak)UIButton *sureButton;
@property (nonatomic , weak)UIImageView *topImagell;
@property (nonatomic , weak)UIButton *getCodeBtn;

@end

@implementation SKRegisterViewController
- (UIImageView *)topImagell
{
    if (!_topImagell) {
        UIImageView *imagell = [[UIImageView alloc] init];
        [self.view addSubview:imagell];
        WS(weakSelf);
        imagell.image = showImage(@"头图");
    imagell.contentMode = UIViewContentModeScaleAspectFill;
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
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view).offset(0);
            make.top.equalTo(weakSelf.topImagell.mas_bottom).offset(16);
            make.height.equalTo(@(264));
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
        tf.textColor = ktextColor;
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
        tf.placeholder = @"请输入手机验证码";
        tf.font = kFont(17);
        tf.textColor = ktextColor;
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
- (UITextField *)passwordTF
{
    if (!_passwordTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"密码为6位至16位";
        tf.font = kFont(17);
        tf.textColor = ktextColor;
    tf.secureTextEntry = YES;
        tf.textAlignment = NSTextAlignmentLeft;
     tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-100);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(142);
            make.height.equalTo(@(20));
        }];
        _passwordTF = tf;
    }
    return _passwordTF;
}
- (UITextField *)RecommenderTF
{
    if (!_RecommenderTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"非必填";
        tf.font = kFont(17);
        tf.textColor = ktextColor;
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(103);
            make.right.equalTo(weakSelf.view.mas_right).offset(-100);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(203);
            make.height.equalTo(@(20));
        }];
        _RecommenderTF = tf;
    }
    return _RecommenderTF;
}


- (UIButton *)protocolSelectBtn {
    if (!_protocolSelectBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"Shape Copy"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Group"] forState:UIControlStateSelected];
        button.selected = YES;
        [button addTarget:self action:@selector(protocolSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        CGFloat top = 8;
        if (kScreenWidth > 350) {
            top = 20;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(13);
            make.top.equalTo(weakSelf.bgView.mas_bottom).offset(-5);
            make.height.equalTo(@(20));
            make.width.equalTo(@(20));
        }];
        _protocolSelectBtn = button;
    }
    return _protocolSelectBtn;
}

- (UIButton *)protocolBtn
{
    if (!_protocolBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"注册协议" forState:0];
        [button setTitleColor:KBlueColor forState:0];
        button.titleLabel.font = kFont(12);
        [button addTarget:self action:@selector(procolClick:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
        CGFloat top = 8;
        if (kScreenWidth > 350) {
            top = 20;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.protocolSelectBtn.mas_right).offset(13);
            make.top.equalTo(weakSelf.protocolSelectBtn);
            make.height.equalTo(@(20));
        }];
        _protocolBtn = button;
    }
    return _protocolBtn;
}


- (UIButton *)sureButton
{
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即注册" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = kFont(17);
        button.layer.backgroundColor = [UIColor hexStringToColor:@"#4062f4"].CGColor;
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 22.5;
        [button addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        WS(weakSelf);
        [self.view addSubview:button];
    CGFloat top = 8;
    if (kScreenWidth > 350) {
    top = 20;
    }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(13);
            make.right.equalTo(weakSelf.view.mas_right).offset(-13);
            make.top.equalTo(weakSelf.bgView.mas_bottom).offset(top);
            make.height.equalTo(@(45));
        }];
        _sureButton = button;
    }
    return _sureButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _registertoken = @"";
    [self addnickLab];
    [self nickTF];
    [self getCodeBtn];
    [self passwordTF];
    [self RecommenderTF];
    [self protocolSelectBtn];
    [self protocolBtn];
    [self sureButton];
    
}
- (void)addnickLab
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"手机号";
    label.font = kFont(18);
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
    label2.font = kFont(18);
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
        make.top.equalTo(weakSelf.bgView.mas_top).offset(120);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"密码";
    label3.font = kFont(18);
    label3.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label3.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(142);
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
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"推荐码";
    label4.font = kFont(18);
    label4.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label4.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(203);
        make.height.equalTo(@(20));
        make.width.equalTo(@(72));
    }];
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView4];
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(weakSelf.view).offset(0);
    make.top.equalTo(label4.mas_bottom).offset(20);
    make.height.equalTo(@(1));
    }];
}
#pragma mark --> 获取验证码
- (void)getcodeNum
{
    WS(weakSelf);
    if (![self checkphoneNumber]){
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
                _registertoken = [JSON objectForKey:@"registertoken"];
            }else{
                _registertoken = @"";
                [weakSelf.view toastShow:msg];
            }
        } andfail:^(NSError *error) {
            [weakSelf.view toastShow:netFailString];
        } path:@"applyRegister"];
    }
}

#pragma  mark 注册协议
- (void)procolClick:(UIButton *)btn {
    BSWKwebViewController *base = [BSWKwebViewController new];
    base.title = @"注册协议";
    base.url = [NSString stringWithFormat:@"http://wap.qcygu.com/user/zcxy_new.html?appType=1"];
    [self.navigationController pushViewController:base animated:YES];
                    
}

- (void)protocolSelectBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
}

#pragma mark --> 点击开始注册
- (void)sureClick:(UIButton *)sender
{
    if (self.cardNumTF.text.length > 1 && self.passwordTF.text.length >= 6 && self.nickTF.text.length > 0) {
        if (self.protocolSelectBtn.selected == NO) {
            [self.view toastShow:@"请阅读并同意注册协议"];
            return;
        }
       [self loginIn];
        
    }else{
        [self.view toastShow:@"请检查手机号码或者验证码"];
    }
}
- (void)loginIn
{
    WS(weakSelf);
    NSDictionary *parasmeter = @{@"mobile":self.nickTF.text,@"smscode":self.cardNumTF.text,@"recommend":_RecommenderTF.text,@"password":_passwordTF.text,@"token":_registertoken,@"qd":@"ios1"};
    [SVCCommunityApi RegUserWithNSDictionary:parasmeter BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            NSDictionary *dict = [JSON objectForKey:@"userinfo"];
            SKUserInfoModel *model = [SKUserInfoModel modelWithDict:dict];
            [model saveUserModel];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessful" object:nil];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            /**
             添加手势密码
             */
            GestureLockView * lock=[[GestureLockView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) hiddenBottom:NO bottomBtnTag:1];
            lock.setSuccess = ^{
                [lock removeFromSuperview];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:GestureTag];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:lock];
        }
        [weakSelf.view toastShow:msg];
    } andfail:^(NSError *error) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark --> 键盘收起
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
- (void)back
{
    if (self.type == 2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
