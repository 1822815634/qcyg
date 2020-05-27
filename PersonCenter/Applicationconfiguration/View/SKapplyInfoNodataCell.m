//
//  SKapplyInfoNodataCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKapplyInfoNodataCell.h"

@implementation SKapplyInfoNodataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)applyClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKapplyInfoNodataCellClick)]) {
        [_vDelegate SKapplyInfoNodataCellClick];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
