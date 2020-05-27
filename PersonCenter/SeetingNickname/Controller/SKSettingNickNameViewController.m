//
//  SKSettingNickNameViewController.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/23.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKSettingNickNameViewController.h"

@interface SKSettingNickNameViewController ()<UITextFieldDelegate>
@property (nonatomic , weak)UIView *bgView;
@property (nonatomic , weak)UITextField *nickTF;
@property (nonatomic , weak)UIButton *sureButton;
@end

@implementation SKSettingNickNameViewController
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
            make.height.equalTo(@(60));
        }];
        _bgView = view;
    }
    return _bgView;
}
- (UITextField *)nickTF
{
    if (!_nickTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入新的昵称";
        tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        tf.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.delegate = self;
        WS(weakSelf);
        [weakSelf.bgView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).offset(73);
            make.right.equalTo(weakSelf.view.mas_right).offset(-100);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
            make.height.equalTo(@(20));
        }];
        _nickTF = tf;
    }
    return _nickTF;
}
- (UIButton *)sureButton
{
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"提交" forState:0];
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
    [self addnickLab];
    [self nickTF];
    [self sureButton];
    // Do any additional setup after loading the view.
}
- (void)addnickLab
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"昵称";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    WS(weakSelf);
    [weakSelf.bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(45));
    }];
}
- (void)sureClick
{
    WS(weakSelf);
    if (_nickTF.text.length < 1) {
        [weakSelf.view toastShow:@"请输入修改的昵称"];
        return;
    }else{
        NSDictionary *param = @{@"token":[SKUserInfoModel userToken],@"nickname":_nickTF.text};
        [SVCCommunityApi setUserNicknameNSDictionary:param BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
            if (code == 0) {
                [weakSelf.view toastShow:@"修改成功"];
                if (_vDelegate && [_vDelegate respondsToSelector:@selector(setNicknameSuccessful:)]) {
                    [_vDelegate setNicknameSuccessful:_nickTF.text];
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view toastShow:msg];
            }
        } andfail:^(NSError *error) {
            [weakSelf.view toastShow:netFailString];
        }];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view  endEditing:YES];
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
