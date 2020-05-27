//
//  SKgoodsRuledetailView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKgoodsRuledetailView.h"

@interface SKgoodsRuledetailView ()
@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@end

@implementation SKgoodsRuledetailView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _applyButton.layer.cornerRadius = 22.5;
    _applyButton.clipsToBounds = YES;
}

+ (SKgoodsRuledetailView *)initWithinstancetype
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKgoodsRuledetailView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void)initWithSKgoodsRuleView:(NSInteger)num
{
    if (num == 1) {
        [_applyButton setTitle:@"积分不足" forState:0];
        _applyButton.layer.backgroundColor = [UIColor colorWithRed:249/255.0 green:167/255.0 blue:161/255.0 alpha:1.0].CGColor;
    }else{
        [_applyButton setTitle:@"立即兑换" forState:0];
        _applyButton.layer.backgroundColor = [UIColor colorWithRed:244/255.0 green:60/255.0 blue:43/255.0 alpha:1.0].CGColor;
    }
}
- (IBAction)exchangeClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(exchangeClick)]) {
        [_vDelegate exchangeClick];
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
