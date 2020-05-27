//
//  SKSmallintagraCollectionCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/24.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKSmallintagraCollectionCell.h"

@interface SKSmallintagraCollectionCell ()

@property (nonatomic , weak)UIView *bgView;

@property (nonatomic , weak)UILabel *leftSignLab;

@property (nonatomic , weak)UILabel *SignNumLab;

@property (nonatomic , weak)UILabel *midLab;

@property (nonatomic , weak)UIButton *signButton;

@property (nonatomic , weak)UIButton *ruleButton;

@end

@implementation SKSmallintagraCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.midLab.text = @"我的积分";
        [self.signButton setTitle:@"签到" forState:0];
    }
    return self;
}
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15,18,kScreenWidth - 30,180);
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,kScreenWidth - 30,180);
        gl.startPoint = CGPointMake(0.94, 0.03);
        gl.endPoint = CGPointMake(0.2, 0.93);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:29/255.0 blue:55/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:147/255.0 blue:113/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [view.layer addSublayer:gl];
        view.layer.cornerRadius = 10;
        view.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:79/255.0 alpha:0.3].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,19);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 17;
        view.clipsToBounds = YES;
        [self.contentView addSubview:view];
        _bgView = view;
        view.layer.cornerRadius = 20;
    }
    return _bgView;
}
- (UILabel *)leftSignLab
{
    if (!_leftSignLab) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,15,200,20);
        label.centerY = self.ruleButton.centerY;
        label.numberOfLines = 0;
        [self.bgView addSubview:label];
        label.font = kFont(14);
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        label .alpha = 1.0;
        _leftSignLab = label;
    }
    return _leftSignLab;
}
- (UILabel *)SignNumLab
{
    if (!_SignNumLab) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,53,kScreenWidth - 60,36);
         label.centerX = self.contentView.centerX;
        label.numberOfLines = 0;
        [self.bgView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont(43);
        label.textColor = [UIColor colorWithRed:255/255.0 green:211/255.0 blue:38/255.0 alpha:1.0];
        label .alpha = 1.0;
        _SignNumLab = label;
    }
    return _SignNumLab;
}
- (UILabel *)midLab
{
    if (!_midLab) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(30,96,kScreenWidth - 90,15);
        label.numberOfLines = 0;
        label.centerX = self.contentView.centerX;
        [self.bgView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont(12);
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        label .alpha = 1.0;
        _midLab = label;
    }
    return _midLab;
}
- (UIButton *)ruleButton
{
    if (!_ruleButton) {
        UIButton *leftBtn = [[UIButton alloc] init];
        [leftBtn setTitle:@"规则" forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"规则"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"规则"] forState:UIControlStateHighlighted];
        [leftBtn setImage:[UIImage imageNamed:@"规则"] forState:UIControlStateSelected];
        leftBtn.titleLabel.font = kFont(14);
        leftBtn.frame = CGRectMake(kScreenWidth - 85, 15, 55, 30);
        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
       leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -leftBtn.titleLabel.frame.size.width - leftBtn.frame.size.width + leftBtn.imageView.frame.size.width);
        leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -leftBtn.imageView.frame.size.width - leftBtn.frame.size.width + leftBtn.titleLabel.frame.size.width, 0, 0);
        leftBtn.tag = 9;
        [leftBtn addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:leftBtn];
        _ruleButton = leftBtn;
    }
    return _ruleButton;
}
- (UIButton *)signButton
{
    if (!_signButton) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom] ;
        but.frame = CGRectMake(127.5,125,120,40);
        but.centerX = self.contentView.centerX;
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame =  CGRectMake(0,0,120,40);
        gl.startPoint = CGPointMake(0.13, 0.22);
        gl.endPoint = CGPointMake(0.95, 0.83);
          gl.locations = @[@(0), @(1.0f)];
        gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:236/255.0 blue:120/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:196/255.0 blue:0/255.0 alpha:1.0].CGColor];
        [but.layer addSublayer:gl];
        but.layer.cornerRadius = 22.5;
        but.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:45/255.0 blue:63/255.0 alpha:0.5].CGColor;
        but.tag = 10;
        [but addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitleColor:[UIColor hexStringToColor:@"FF5700"] forState:UIControlStateNormal];
        but.clipsToBounds= YES;
        but.layer.shadowOffset = CGSizeMake(0,5);
        but.layer.shadowOpacity = 1;
        but.layer.shadowRadius = 5;
        [self.bgView addSubview:but];
        _signButton = but;
    }
    return _signButton;
}
- (void)signIn:(UIButton *)sender
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKSmallintagraCollectionRuleDidClick:)]) {
        [_vDelegate SKSmallintagraCollectionRuleDidClick:sender.tag];
    }
}
- (void)setupSignLab:(NSString *)sign Num:(NSString *)signNum
{
    self.leftSignLab.text = sign;
    self.SignNumLab.text = signNum;
}
@end
