//
//  SKJunirowmangerFeeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/13.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKJunirowmangerFeeCell.h"

@interface SKJunirowmangerFeeCell ()
@property (weak, nonatomic) IBOutlet UILabel *feeLab;
@property (weak, nonatomic) IBOutlet UILabel *msgLab;

@end

@implementation SKJunirowmangerFeeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setJunirowMangerFeeCellwithfree:(NSString *)free msg:(NSString *)msg
{
    _feeLab.text = [NSString stringWithFormat:@"%@",free];
    _msgLab.text = msg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
