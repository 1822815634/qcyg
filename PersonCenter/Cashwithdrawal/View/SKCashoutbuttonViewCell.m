//
//  SKCashoutbuttonViewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKCashoutbuttonViewCell.h"
@interface SKCashoutbuttonViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *cashoutButton;
@property (weak, nonatomic) IBOutlet UIView *bgview;

@end
@implementation SKCashoutbuttonViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cashoutButton.clipsToBounds = YES;
    _cashoutButton.layer.cornerRadius = 22.5;
}
- (void)setbuttontile:(NSString *)title type:(NSInteger)type
{
    [_cashoutButton setTitle:title forState:0];
    if (type == 1) {
        _bgview.backgroundColor = [UIColor whiteColor];
    }else{
        _bgview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}
- (IBAction)senderClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(senderDidClick)]) {
        [_vDelegate senderDidClick];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
