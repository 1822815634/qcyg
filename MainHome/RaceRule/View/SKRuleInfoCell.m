//
//  SKRuleInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRuleInfoCell.h"

@interface SKRuleInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@end

@implementation SKRuleInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setNumlab:(NSString *)numString money:(NSString *)money
{
    _numLab.text = numString;
    _moneyLab.text = money;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
