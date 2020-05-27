//
//  SKMainFootView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKMainFootView.h"
@interface SKMainFootView ()

@property (nonatomic , weak)UILabel *shenmingLab;

@property (nonatomic , weak)UILabel *tishiLab;

@end
@implementation SKMainFootView
- (UILabel *)shenmingLab
{
    if (!_shenmingLab) {
        UILabel *label = [[UILabel alloc] init];
        WS(weakSelf);
        label.text = @"Copyright © 2014-2020 钱程优顾版权所有";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 1;
        label.numberOfLines = 0;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.top.equalTo(weakSelf.mas_bottom).offset(-48);
            make.height.equalTo(@(15));
        }];
        _shenmingLab = label;
    }
    return _shenmingLab;
}
- (UILabel *)tishiLab
{
    if (!_tishiLab) {
        UILabel *label = [[UILabel alloc] init];
        WS(weakSelf);
        label.text = @"股市有风险 投资需谨慎";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label.textColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 1;
        label.numberOfLines = 0;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(15);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.top.equalTo(weakSelf.mas_bottom).offset(-31);
            make.height.equalTo(@(15));
        }];
        _tishiLab = label;
    }
    return _tishiLab;
}
- (void)setupFootView
{
    [self shenmingLab];
    [self tishiLab];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
