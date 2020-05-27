//
//  SKoutLoginCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKoutLoginCell.h"

@interface SKoutLoginCell ()

@property (nonatomic , weak)UIButton *logoutButton;

@end

@implementation SKoutLoginCell
- (UIButton *)logoutButton
{
    if (!_logoutButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"退出登录" forState:0];
        WS(weakSelf);
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
       [btn setTitleColor:[UIColor colorWithRed:68/255.0 green:64/255.0 blue:62/255.0 alpha:1] forState:0];
        [btn addTarget:self action:@selector(outLog) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(weakSelf).offset(0);
        }];
        _logoutButton = btn;
    }
    return _logoutButton;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self logoutButton];
    }
    return self;
}
- (void)outLog
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKoutLogoutCellClick)]) {
        [_vDelegate SKoutLogoutCellClick];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
