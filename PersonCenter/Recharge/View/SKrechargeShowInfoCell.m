//
//  SKrechargeShowInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKrechargeShowInfoCell.h"
@interface SKrechargeShowInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation SKrechargeShowInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.borderColor = [UIColor colorWithRed:185/255.0 green:192/255.0 blue:198/255.0 alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
