//
//  SKAgreetRiskstatementView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/6/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAgreetRiskstatementView.h"

@interface SKAgreetRiskstatementView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *aggretBtn;

@end

@implementation SKAgreetRiskstatementView

+ (SKAgreetRiskstatementView *)instanceSKAgreetRiskstatementView
{
     NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKAgreetRiskstatementView" owner:nil options:nil];
     return [nibView objectAtIndex:0];
}
- (IBAction)agreetClick:(UIButton *)sender {
     [self removeFromSuperview];
     if(_vDelegate && [_vDelegate respondsToSelector:@selector(aggretRisk)]){
     [_vDelegate aggretRisk];
     }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 6;
_aggretBtn.clipsToBounds = YES;
_aggretBtn.layer.cornerRadius = 4;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
