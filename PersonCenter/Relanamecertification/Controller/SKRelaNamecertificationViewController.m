//
//  SKRelaNamecertificationViewController.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/23.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRelaNamecertificationViewController.h"

@interface SKRelaNamecertificationViewController ()<UITextFieldDelegate>
@property (nonatomic , weak)UIView *bgView;
@property (nonatomic , weak)UITextField *nickTF;
@property (nonatomic , weak)UITextField *cardNumTF;
@property (nonatomic , weak)UIButton *sureButton;
@property (nonatomic , weak)UILabel *statuesLab;
@end

@implementation SKRelaNamecertificationViewController
- (UILabel *)statuesLab
{
if (!_statuesLab) {
UILabel *lab = [[UILabel alloc] init];
lab.backgroundColor = [UIColor orangeColor];
//lab.textColor = [UIColor orangeColor];
lab.font = kFont(15);
[self.view addSubview:lab];
WS(weakSelf);
[lab mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.right.equalTo(weakSelf.view).offset(0);
make.top.equalTo(weakSelf.view.mas_top).offset(10);
}];
_statuesLab = lab;
}
return _statuesLab;
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
        make.top.equalTo(weakSelf.statuesLab.mas_bottom).offset(0);
            make.height.equalTo(@(121));
        }];
        _bgView = view;
    }
    return _bgView;
}
- (UITextField *)nickTF
{
    if (!_nickTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入您的真实姓名";
        tf.font = kFont(17);
        tf.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(140);
            make.right.equalTo(weakSelf.view.mas_right).offset(-10);
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
        tf.placeholder = @"请输入您的真实姓名";
        tf.font = kFont(17);
        tf.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(140);
            make.right.equalTo(weakSelf.view.mas_right).offset(-10);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(81);
            make.height.equalTo(@(20));
        }];
        _cardNumTF = tf;
    }
    return _cardNumTF;
}
- (UIButton *)sureButton
{
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"完成" forState:0];
        [button setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:0];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        button.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
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
    if (self.name_Type == RelaName) {
         [self addnickLab:@"真实姓名" text:@"身份证号"];
        self.nickTF.placeholder = @"请输入您的真实姓名";
        self.cardNumTF.placeholder = @"请输入您的身份证号";
    [self getrealStatues];
    [self.statuesLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@(45));
    }];
    }else if(self.name_Type == Relapassword){
    [self addnickLab:@"支付密码" text:@"确认支付密码"];
    self.nickTF.placeholder = @"请输入支付密码";
//    self.nickTF.keyboardType = UIKeyboardTypeNumberPad;
    self.cardNumTF.placeholder = @"确认支付密码";
//     self.cardNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.statuesLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@(0));
    }];
    }else{
        [self addnickLab:@"旧密码" text:@"新密码"];
        self.nickTF.placeholder = @"请输入旧密码";
        self.cardNumTF.placeholder = @"请输入密码";
    [self.statuesLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@(0));
    }];
    }
    [self.sureButton setTitle:@"提交" forState:0];
    [self nickTF];
    [self cardNumTF];
    [self sureButton];
}
- (void)getrealStatues
{
     WS(weakSelf);
     [SVCCommunityApi commitRelaNicknameNSDictionary:@{@"token":[SKUserInfoModel userToken]} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
     if (code == 0) {
     NSDictionary *dict = [JSON objectForKey:@"data"];
     NSString *stutueString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
         [weakSelf setStatuesLabText:stutueString];
         if ([stutueString isEqualToString:@"2"]) {
             weakSelf.sureButton.hidden = YES;
         }else {
             weakSelf.sureButton.hidden = NO;
         }
         if (![stutueString isEqualToString:@"3"]) {
             [weakSelf setRelatext:dict];
         }
     }
     } andfail:^(NSError *error) {

     } path:@"getreal"];
}
- (void)setStatuesLabText:(NSString *)status
{
     if ([status isEqualToString:@"0"]) {
     _statuesLab.text = @"  审核中";
     }else if ([status isEqualToString:@"1"]){
     _statuesLab.text = @"  未通过";
     }else if ([status isEqualToString:@"2"]){
     _statuesLab.text = @"  通过";
     }else{
     _statuesLab.text = @"  未设置";
     }
}
- (void)setRelatext:(NSDictionary *)dict
{
     _nickTF.text = [dict objectForKey:@"realname"];
     _cardNumTF.text = [dict objectForKey:@"cartid"];
}
- (void)addnickLab:(NSString *)text1 text:(NSString *)text2
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text1;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    WS(weakSelf);
    [weakSelf.bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(140));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
    [self.bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(60);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = text2;
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label2.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label2.textAlignment = NSTextAlignmentLeft;
    [weakSelf.bgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(81);
        make.height.equalTo(@(20));
        make.width.equalTo(@(140));
    }];
}
- (void)sureClick
{
    if (self.name_Type == RelaName) {
        [self commitRelanInfo:@"real" param: @{@"token":[SKUserInfoModel userToken],@"realname":_nickTF.text,@"cartid":_cardNumTF.text}];
    }else if(self.name_Type == loginPwd){
       [self commitRelanInfo:@"setpassword" param: @{@"token":[SKUserInfoModel userToken],@"oldpassword":_nickTF.text,@"newpassword":_cardNumTF.text}];
    }else{
       [self commitRelanInfo:@"trade_pwd" param: @{@"token":[SKUserInfoModel userToken],@"tradepwd1":_nickTF.text,@"tradepwd2":_cardNumTF.text}];
    }
}
- (void)commitRelanInfo:(NSString *)path param:(NSDictionary *)params
{
    WS(weakSelf);
    if (_nickTF.text.length < 1 || _cardNumTF.text.length < 1) {
        [weakSelf.view toastShow:@"请检查您的输入信息"];
    }
    [SVCCommunityApi commitRelaNicknameNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
         [weakSelf.view toastShow:msg];
        if (code == 0) {
        if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(setSuccessful)]) {
        [_Vdelegate setSuccessful];
        }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    } path:path];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
