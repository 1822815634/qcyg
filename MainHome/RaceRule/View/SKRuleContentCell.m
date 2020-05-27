//
//  SKRuleContentCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRuleContentCell.h"

@interface SKRuleContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation SKRuleContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setContentLabtext:(NSString *)content
{
    _contentLab.text = content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
