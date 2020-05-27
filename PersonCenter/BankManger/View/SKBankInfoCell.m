//
//  SKBankInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBankInfoCell.h"

@interface SKBankInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *RelieveButton;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumLab;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@end

@implementation SKBankInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 3.0f;
    _RelieveButton.clipsToBounds = YES;
    _RelieveButton.layer.cornerRadius = 15;
}
- (IBAction)RelieveClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKbankCardmoveClick)]) {
        [_vDelegate SKbankCardmoveClick];
    }
}
- (void)setBankInfoWithDict:(NSDictionary *)dict
{
    _bankNameLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bank"]];
    _bankCardNumLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bankcode"]];
    _nickNameLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"user"]];
    _phoneLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"address"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
