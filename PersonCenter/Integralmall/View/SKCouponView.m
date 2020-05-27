//
//  SKCouponView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/25.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKCouponView.h"

@implementation SKCouponView

+ (SKCouponView *)initWithinstancetype
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKCouponView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
