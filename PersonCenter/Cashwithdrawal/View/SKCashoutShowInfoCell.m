//
//  SKCashoutShowInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKCashoutShowInfoCell.h"
@interface SKCashoutShowInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end
@implementation SKCashoutShowInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = 2.5;
    // Initialization code
}
- (void)settitleLab:(NSString *)title dec:(NSString *)dec
{
    _titleLab.text = title;
    _detailLab.text = dec;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
