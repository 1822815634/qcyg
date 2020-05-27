//
//  SKPersonMainTypeCell.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/14.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPersonMainTypeCell.h"
@interface SKPersonMainTypeCell ()

@end
@implementation SKPersonMainTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)TypeClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKPersonMainTypeCellClick:)]) {
        [_vDelegate SKPersonMainTypeCellClick:sender.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
