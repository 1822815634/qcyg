//
//  SKNewPhoneViewController.m
//  Stockallocation
//
//  Created by wuyou on 2020/3/20.
//  Copyright © 2020年 SoWhat. All rights reserved.
//

#import "SKNewPhoneViewController.h"
#import "UIButton+CountDown.h"
#import "SVCTabBarController.h"
@interface SKNewPhoneViewController ()

@property (nonatomic , strong)UILabel *changeLabel;

@property (nonatomic , strong)UILabel *phoneLabel;

@property (nonatomic , strong)UIView *topBgView;

@property (nonatomic , strong)UILabel *numberLabel;

@property (nonatomic , strong)UITextField *phoneField;

@property (nonatomic,  strong)UIView *lineView;

@property (nonatomic , strong)UIView *bgView;

@property (nonatomic , strong)UILabel *testLabel;

@property (nonatomic , strong)UITextField *testField;

@property (nonatomic , strong)UIButton *earnbtn;

@property (nonatomic , strong)UIButton *nextbtn;

@end

@implementation SKNewPhoneViewController
- (UILabel *)changeLabel {
    if (_changeLabel == nil) {
        _changeLabel = [[UILabel alloc] init];
        _changeLabel.text = @"请输入新的手机号及短信验证码";
        _changeLabel.font = [UIFont boldSystemFontOfSize:18];
        _changeLabel.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        WS(weakSelf);
        [weakSelf.view addSubview:_changeLabel];
        [_changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view.mas_top).offset(50);
            make.centerX.equalTo(weakSelf.view);
        }];
    }
    return _changeLabel;
}

- (UILabel *)phoneLabel {
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"修改成功后下次登录需要使用新手机号";
        _phoneLabel.font = [UIFont systemFontOfSize:15];
        _phoneLabel.textColor = [UIColor grayColor];
        WS(weakSelf);
        [weakSelf.view addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.changeLabel.mas_bottom).offset(15);
            make.centerX.equalTo(weakSelf.view);
        }];
    }
    return _phoneLabel;
}

-
(UIView *)topBgView {
    if (_topBgView == nil) {
        _topBgView = [UIView new];
        [self.view addSubview:_topBgView];
        WS(weakSelf);
        [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(40);
            make.left.mas_equalTo(weakSelf.view);
            make.width.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(50);
        }];
    }
    return _topBgView;
}

- (UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"手机号";
        _numberLabel.font = [UIFont systemFontOfSize:15];
        _numberLabel.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        WS(weakSelf);
        [weakSelf.topBgView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.topBgView.mas_left).offset(30);
            make.centerY.mas_equalTo(weakSelf.topBgView);
        }];
    }
    return _numberLabel;
}

- (UITextField *)phoneField {
    if (_phoneField == nil) {
        _phoneField = [UITextField new];
        _phoneField.font = [UIFont systemFontOfSize:15];
        _phoneField.placeholder = @"请输入新手机号";
        WS(weakSelf);
        [weakSelf.topBgView addSubview:_phoneField];
        [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.topBgView).offset(-20);
            make.left.mas_equalTo(weakSelf.numberLabel.mas_right).offset(30);
            make.centerY.mas_equalTo(weakSelf.topBgView);
        }];
    }
    return _phoneField;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        [self.view addSubview:_bgView];
        WS(weakSelf);
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.topBgView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.view);
            make.width.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(50);
        }];
    }
    return _bgView;
}

- (UILabel *)testLabel {
    if (_testLabel == nil) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.text = @"验证码";
        _testLabel.font = [UIFont systemFontOfSize:15];
        _testLabel.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        WS(weakSelf);
        [weakSelf.bgView addSubview:_testLabel];
        [_testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bgView.mas_left).offset(30);
            make.centerY.mas_equalTo(weakSelf.bgView);
        }];
    }
    return _testLabel;
}

- (UITextField *)testField {
    if (_testField == nil) {
        _testField = [UITextField new];
        _testField.font = [UIFont systemFontOfSize:15];
        _testField.placeholder = @"请输入验证码";
        WS(weakSelf);
        [weakSelf.bgView addSubview:_testField];
        [_testField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.bgView).offset(-120);
            make.left.mas_equalTo(weakSelf.testLabel.mas_right).offset(30);
            make.centerY.mas_equalTo(weakSelf.bgView);
        }];
    }
    return _testField;
}

- (UIButton *)earnbtn {
    if (_earnbtn == nil) {
        _earnbtn = [UIButton new];
        _earnbtn.layer.cornerRadius = 5;
        _earnbtn.layer.masksToBounds = YES;
        _earnbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_earnbtn setTitle:@"点击获取" forState:UIControlStateNormal];
        [_earnbtn setBackgroundColor:KBlueColor];
        [_earnbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WS(weakSelf);
        [weakSelf.bgView addSubview:_earnbtn];
        [_earnbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.bgView).offset(-20);
            make.left.mas_equalTo(weakSelf.testField.mas_right).offset(20);
            make.centerY.mas_equalTo(weakSelf.bgView);
            make.height.mas_equalTo(30);
        }];
    }
    return _earnbtn;
}

- (UIButton *)nextbtn {
    if (_nextbtn == nil) {
        _nextbtn = [UIButton new];
        _nextbtn.layer.cornerRadius = 5;
        _nextbtn.layer.masksToBounds = YES;
        _nextbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_nextbtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_nextbtn setBackgroundColor:KBlueColor];
        [_nextbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WS(weakSelf);
        [weakSelf.view addSubview:_nextbtn];
        [_nextbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.view).offset(-30);
            make.left.mas_equalTo(weakSelf.view).offset(30);
            make.top.mas_equalTo(weakSelf.bgView.mas_bottom).offset(100);
            make.height.mas_equalTo(40);
        }];
    }
    return _nextbtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TableViewBGColor;
    [self makeUI];
    // Do any additional setup after loading the view.
}

- (void)makeUI{
    self.changeLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    self.topBgView.backgroundColor = [UIColor whiteColor];
    self.numberLabel.textAlignment = NSTextAlignmentLeft;
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.testLabel.textAlignment = NSTextAlignmentLeft;
    self.testField.keyboardType = UIKeyboardTypeNumberPad;
    [self.earnbtn addTarget:self action:@selector(earnbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nextbtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)earnbtnClick {
    if ([self.phoneField.text isEqualToString:@""]) {
        [WSProgressHUD showErrorWithStatus:@"请输入新手机号"];
        return;
    }
    WS(weakSelf);
    [SVCCommunityApi getSmsCode:@{@"token":[SKUserInfoModel userToken],@"type":@"2",@"tel":self.phoneField.text} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.earnbtn startWithSeconds:60];
        }else {
            [WSProgressHUD showErrorWithStatus:msg];
        }
    } andfail:^(NSError *error) {
        
    } path:@"get_sms_code"];
}

- (void)nextBtnClick {
    if ([self.phoneField.text isEqualToString:@""]) {
        [WSProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if ([self.testField.text isEqualToString:@""]) {
        [WSProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    WS(weakSelf);
    [SVCCommunityApi up_tel:@{@"token":[SKUserInfoModel userToken],@"code":self.oldCode,@"new_tel":self.phoneField.text,@"new_code":self.testField.text} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            //修改成功
            [self loginOut];
        } else {
            [WSProgressHUD showErrorWithStatus:msg];
        }
    } andfail:^(NSError *error) {
        
    } path:@"up_tel"];
}

- (void)loginOut {
    [SKUserInfoModel deleteModel];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:GestureWord];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:GestureTag];
    [self.navigationController popToRootViewControllerAnimated:YES];
    SVCTabBarController *tabbar = [[SVCTabBarController alloc] init];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    keyWindow.rootViewController = tabbar;
    tabbar.selectedIndex = 0;
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
