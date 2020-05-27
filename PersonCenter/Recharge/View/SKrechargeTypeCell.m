//
//  SKrechargeTypeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKrechargeTypeCell.h"
@interface SKrechargeTypeCell ()
@property (weak, nonatomic) IBOutlet UILabel *payTypeLab;

@end
@implementation SKrechargeTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)selectedType:(NSString *)type
{
    _payTypeLab.text = type;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
