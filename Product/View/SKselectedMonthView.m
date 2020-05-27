//
//  SKselectedMonthView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKselectedMonthView.h"

@interface SKselectedMonthView ()
{
    NSInteger _currentMonth;
}
@end

@implementation SKselectedMonthView

#pragma mark --> xib加载月份选择视图
+ (SKselectedMonthView *)instanceSKselectedMonthView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKselectedMonthView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (IBAction)sureClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(changeMonth:)]) {
        [_vDelegate changeMonth:_currentMonth];
    }
     [self removeFromSuperview];
}
- (IBAction)cancelClick:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)monthSelected:(UIButton *)sender {
    [self selectedButtonchangeBackColor:sender.tag];
}
- (void)selectedButtonchangeBackColor:(NSInteger)tag
{
    _currentMonth = tag - 1000;
    for (NSInteger i = 1001; i < 1007; i ++) {
        UIButton *button = (UIButton *)[self viewWithTag:i];
        if (i == tag) {
            [button setTitleColor:[UIColor hexStringToColor:@"3F434F"] forState:0];
        }else{
              [button setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
- (void)show:(NSInteger)month
{
    [self selectedButtonchangeBackColor:month + 1000];
}
@end
