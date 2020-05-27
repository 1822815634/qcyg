//
//  SKAnalogdiskHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/15.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAnalogdiskHeaderView.h"

@interface SKAnalogdiskHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *assetsLab;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;
@property (weak, nonatomic) IBOutlet UILabel *marketsLab;
@property (weak, nonatomic) IBOutlet UILabel *earningsLab;
@property (weak, nonatomic) IBOutlet UILabel *dayearningsLab;
@property (weak, nonatomic) IBOutlet UILabel *weekearningsLab;

@end

@implementation SKAnalogdiskHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgView.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
}
- (void)setupViewwithassets:(NSString *)assets market:(NSString *)market balance:(NSString *)balance earnings:(NSString *)earnings dayearnings:(NSString *)dayearnings weekearnings:(NSString *)weekearnings
{
    _earningsLab.text = earnings;
    _assetsLab.text = assets;
    _balanceLab.text = balance;
    _marketsLab.text = market;
    _dayearningsLab.text = dayearnings;
    _weekearningsLab.text = weekearnings;
}

@end
