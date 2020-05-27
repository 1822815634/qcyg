//
//  SKPersonInfoHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPersonInfoHeaderView.h"
@interface SKPersonInfoHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImagell;
@property (weak, nonatomic) IBOutlet UILabel *countAllmoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *yueLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIView *moneyView;

@end
@implementation SKPersonInfoHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupUserInfoHeaderView:(NSDictionary *)dict
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:HudeString]) {
        _moneyView.hidden = YES;
    }
    [_userHeaderImagell sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,[dict objectForKey:@"avatar"]]]];
    _countAllmoneyLab.text = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"summoney"] floatValue]];
    _yueLab.text = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"balance"] floatValue]];
}
- (IBAction)settingClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKPersonInfoHeaderViewSettingClick)]) {
        [_vDelegate SKPersonInfoHeaderViewSettingClick];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
