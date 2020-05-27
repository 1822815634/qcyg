//
//  SKOperaHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/15.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKOperaHeaderView.h"


@interface SKOperaHeaderView ()

@property (nonatomic , weak)UIButton *leftBtn;

@property (nonatomic , weak)UIButton *midBtn;

@property (nonatomic , weak)UIButton *rightBtn;

@property (nonatomic , weak)UIButton *otherBtn;

@property (nonatomic , weak)UIView *lineView;

@property (nonatomic , weak)UIView *bottomLineView;

@property (nonatomic , strong)NSArray *titleArray;

#define buttonFont [UIFont fontWithName:@"PingFangSC-Regular" size:16];
@end

@implementation SKOperaHeaderView
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:BtnbgColor forState:0];
        button.titleLabel.font = buttonFont;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.frame = CGRectMake(0, 0, kScreenWidth/self.titleArray.count, 36);
        [self addSubview:button];
        button.tag = 1;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn = button;
    }
    return _leftBtn;
}
- (UIButton *)midBtn
{
    if (!_midBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/self.titleArray.count, 0, kScreenWidth/self.titleArray.count, 36);
        [button setTitleColor:[UIColor blackColor] forState:0];
        button.titleLabel.font = buttonFont;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.tag = 2;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _midBtn = button;
    }
    return _midBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/self.titleArray.count*2, 0, kScreenWidth/self.titleArray.count, 36);
        button.tag = 3;
        [button setTitleColor:[UIColor blackColor] forState:0];
        button.titleLabel.font = buttonFont;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _rightBtn = button;
    }
    return _rightBtn;
}

- (UIButton *)otherBtn
{
    if (!_otherBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth/self.titleArray.count*3, 0, kScreenWidth/self.titleArray.count, 36);
        button.tag = 4;
        [button setTitleColor:[UIColor blackColor] forState:0];
        button.titleLabel.font = buttonFont;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _otherBtn = button;
    }
    return _otherBtn;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/6 - 30, 37, 60, 3)];
        view.backgroundColor = KBlueColor;
        [self addSubview:view];
        _lineView = view;
    }
    return _lineView;
}
- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, kScreenWidth, 0.5)];
        view.backgroundColor = [UIColor hexStringToColor:@"eeeeee"];
        [self addSubview:view];
        _bottomLineView = view;
    }
    return _bottomLineView;
}
- (void)btnClick:(UIButton *)sender
{
    [self changBtntextColor:sender.tag];
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKOperaHeaderViewTypeViewClick:)]) {
        [_vDelegate SKOperaHeaderViewTypeViewClick:sender.tag];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    UIButton *btn = (UIButton *)[self viewWithTag:selectedIndex];
    [self btnClick:btn];
}

- (void)changBtntextColor:(NSInteger)tag
{
    for (NSInteger i = 1; i <= self.titleArray.count; i ++) {
        UIButton *button = (UIButton *)[self viewWithTag:i];
        if (i == tag) {
            [button setTitleColor:KBlueColor forState:0];
            self.lineView.centerX = button.centerX;
        }else{
            [button setTitleColor:[UIColor blackColor] forState:0];
        }
    }
}
- (void)setupView:(NSInteger)seleType titleArr:(NSArray *)titleArr
{
    self.titleArray = titleArr;
    [self.leftBtn setTitle:titleArr[0] forState:0];
    [self.midBtn setTitle:titleArr[1] forState:0];
    if (titleArr.count >2) {
        [self.rightBtn setTitle:titleArr[2] forState:0];
    }
    if (titleArr.count>3) {
        [self.otherBtn setTitle:titleArr[3] forState:0];
    }
    self.lineView.centerX = self.leftBtn.centerX;
    [self bottomLineView];
    [self changBtntextColor:seleType];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
