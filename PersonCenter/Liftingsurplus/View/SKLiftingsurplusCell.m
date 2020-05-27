//
//  SKLiftingsurplusCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKLiftingsurplusCell.h"
@interface SKLiftingsurplusCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *banlanceLab;

@property (weak, nonatomic) IBOutlet UIButton *SelectAccountButton;


@end
@implementation SKLiftingsurplusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _acountTF.delegate = self;
}

- (IBAction)SelectButtonClick:(UIButton *)sender {
    if (self.selectButtonClick) {
        self.selectButtonClick();
    }
}

-(void)setAccountNum:(NSString *)accountNum{
    _accountNum = accountNum;
    [self.SelectAccountButton setTitle:accountNum forState:UIControlStateNormal];
}
- (void)setBanlance:(NSString *)banlance
{
     _banlance = banlance;
     _banlanceLab.text = banlance;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
