//
//  SKGestureViewController.m
//  Stockallocation
//
//  Created by wuyou on 2019/7/9.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKGestureViewController.h"
#import "SKGestureTapViewController.h"
@interface SKGestureViewController ()

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UISwitch *open;

@property (nonatomic, strong)UIView *changeBgView;


@end

@implementation SKGestureViewController

- (UIView *)changeBgView
{
    if (!_changeBgView) {
        UIView *view = [[UIView alloc] init];
        UIControl *control = [[UIControl alloc]init];
        [control addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:control];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view).offset(0);
            make.top.equalTo(weakSelf.bgView.mas_top).offset(70);
            make.height.equalTo(@(60));
        }];
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view).offset(0);
            make.width.height.equalTo(view).offset(0);
        }];
        _changeBgView = view;
    }
    return _changeBgView;
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
            make.top.equalTo(weakSelf.view.mas_top).offset(10);
            make.height.equalTo(@(60));
        }];
        _bgView = view;
    }
    return _bgView;
}

- (UISwitch *)open {
    if (!_open) {
        UISwitch *open = [[UISwitch alloc]init];
        open.on = [[NSUserDefaults standardUserDefaults]boolForKey:GestureTag];
        [self.view addSubview:open];
        WS(weakSelf);
        [open mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).offset(-10);
            make.centerY.equalTo(weakSelf.bgView);
            [open addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
        }];
        _open = open;
    }
    return _open;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.open.on = [[NSUserDefaults standardUserDefaults]boolForKey:GestureTag];
    self.changeBgView.hidden = !self.open.on;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TableViewBGColor;
    [self makeUI];
    // Do any additional setup after loading the view.
}

- (void)makeUI {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"开启密码锁定";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    WS(weakSelf);
    [weakSelf.bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.centerY.equalTo(weakSelf.bgView);
        make.height.equalTo(@(20));
//        make.width.equalTo(@(45));
    }];
    [self open];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"修改手势密码";
    label1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label1.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
    label1.textAlignment = NSTextAlignmentLeft;
    [weakSelf.changeBgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
        make.centerY.equalTo(weakSelf.changeBgView);
        make.height.equalTo(@(20));
    }];
    
    UIImageView  *you = [[UIImageView alloc] init];
    you.image = [UIImage imageNamed:@"you"];
    [weakSelf.changeBgView addSubview:you];
    [you mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.changeBgView).offset(-15);
        make.centerY.equalTo(weakSelf.changeBgView);
    }];
}

#pragma mark 界面交互
- (void)openClick:(UISwitch *)switc{
    if (switc.isOn) {
       //进入设置手势密码
        SKGestureTapViewController *sk = [SKGestureTapViewController new];
        [self.navigationController pushViewController:sk animated:YES];
    } else {
        //关闭
        self.changeBgView.hidden = !self.open.on;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:GestureTag];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:GestureWord];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)change {
    //修改手势密码
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:GestureWord];
    SKGestureTapViewController *sk = [SKGestureTapViewController new];
    [self.navigationController pushViewController:sk animated:YES];
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
