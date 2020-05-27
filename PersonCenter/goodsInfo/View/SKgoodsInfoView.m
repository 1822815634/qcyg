//
//  SKgoodsInfoView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKgoodsInfoView.h"

@interface SKgoodsInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *centerImagell;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *costLab;

@end

@implementation SKgoodsInfoView

+ (SKgoodsInfoView *)initWithinstancetype
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKgoodsInfoView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)initWithSKgoodsInfoView:(NSDictionary *)dict
{
    [_centerImagell sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"img"]]];
    _titleLab.text = [dict objectForKey:@"name"];
    _typeLab.text = [NSString stringWithFormat:@"类型：%@",[dict objectForKey:@"type"]];
    _priceLab.text = [NSString stringWithFormat:@"价格：%@",[dict objectForKey:@"price"]];
    _costLab.text = [NSString stringWithFormat:@"积分：%@",[dict objectForKey:@"cost"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
