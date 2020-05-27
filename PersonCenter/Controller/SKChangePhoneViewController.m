//
//  SKChangePhoneViewController.m
//  Stockallocation
//
//  Created by wuyou on 2020/3/20.
//  Copyright © 2020年 SoWhat. All rights reserved.
//

#import "SKChangePhoneViewController.h"
#import "SKNewPhoneViewController.h"
#import "UIButton+CountDown.h"
@interface SKChangePhoneViewController ()

@property (nonatomic , strong)UILabel *changeLabel;

@property (nonatomic , strong)UILabel *phoneLabel;

@property (nonatomic , strong)UIView *bgView;

@property (nonatomic , strong)UILabel *testLabel;

@property (nonatomic , strong)UITextField *testField;

@property (nonatomic , strong)UIButton *earnbtn;

@property (nonatomic , strong)UIButton *nextbtn;

@end

@implementation SKChangePhoneViewController

- (UILabel *)changeLabel {
    if (_changeLabel == nil) {
        _changeLabel = [[UILabel alloc] init];
        _changeLabel.text = @"更改登陆手机号需验证您的身份";
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
        _phoneLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
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

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        [self.view addSubview:_bgView];
        WS(weakSelf);
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(40);
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
        [_nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
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
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.testLabel.textAlignment = NSTextAlignmentLeft;
    self.testField.keyboardType = UIKeyboardTypeNumberPad;
    [self.earnbtn addTarget:self action:@selector(earnbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nextbtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)earnbtnClick {
    WS(weakSelf);
    [SVCCommunityApi getSmsCode:@{@"token":[SKUserInfoModel userToken],@"type":@"1"} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            [weakSelf.earnbtn startWithSeconds:60];
        }
    } andfail:^(NSError *error) {
        
    } path:@"get_sms_code"];
}

- (void)nextBtnClick {
    if ([self.testField.text isEqualToString:@""]) {
        [WSProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    WS(weakSelf);
    [SVCCommunityApi smsCheck1:@{@"token":[SKUserInfoModel userToken],@"code":self.testField.text} BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            //进入下一步
            SKNewPhoneViewController *new = [SKNewPhoneViewController new];
            new.oldCode = self.testField.text;
            [self.navigationController pushViewController:new animated:YES];
        } else {
            [WSProgressHUD showErrorWithStatus:msg];
        }
    } andfail:^(NSError *error) {
        
    } path:@"sms_check1"];
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
