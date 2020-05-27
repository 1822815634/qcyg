//
//  SKrechargeBankInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKrechargeBankInfoCell.h"

@interface SKrechargeBankInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bankImagell;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;

@end

@implementation SKrechargeBankInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setbankInfo:(NSString *)bank
{
    NSString *imagpath = [NSString stringWithFormat:@"%@icon",bank];
    _bankImagell.image = showImage(imagpath);
    _bankNameLab.text = bank;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
