//
//  SKCashNumCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKCashNumCell.h"
@interface SKCashNumCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@end
@implementation SKCashNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countNumTF.delegate = self;
    
    // Initialization code
}
- (void)initBalanceLab:(NSString *)balance
{
    _balanceLab.text = [NSString stringWithFormat:@"可用余额： %@",balance];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
