//
//  SKInvitationNullCell.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKInvitationNullCell.h"

@interface SKInvitationNullCell ()
@property (weak, nonatomic) IBOutlet UIButton *invitationButton;

@end

@implementation SKInvitationNullCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _invitationButton.clipsToBounds = YES;
    _invitationButton.layer.cornerRadius = 22.5;
    // Initialization code
}
- (IBAction)invitationClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKInvitationNullCellClick)]) {
        [_vDelegate SKInvitationNullCellClick];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
