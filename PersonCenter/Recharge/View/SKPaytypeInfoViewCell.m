//
//  SKPaytypeInfoViewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPaytypeInfoViewCell.h"
@interface SKPaytypeInfoViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *countNameLab;
@property (weak, nonatomic) IBOutlet UILabel *countNicknameLab;
@property (weak, nonatomic) IBOutlet UILabel *countTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *countTypeInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *countInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *countInfodetailLab;
@property (weak, nonatomic) IBOutlet UIImageView *centerImagell;

@end
@implementation SKPaytypeInfoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupViewType:(NSInteger)type countName:(NSString *)countName conutType:(NSString *)countType countInfo:(NSString *)countInfo imagPath:(NSString *)path
{
    if (type == 1) {
        _countNameLab.text = @"支付账户：";
        _countTypeLab.text = @"支付方式：";
        _countInfoLab.text = @"户名：";
    }else{
        _countNameLab.text = @"账户：";
        _countTypeLab.text = @"户名：";
        _countInfoLab.text = @"开户行：";
    }
    _countNicknameLab.text = countName;
    _countTypeInfoLab.text = countType;
    _countInfodetailLab.text = countInfo;
    [_centerImagell sd_setImageWithURL:[NSURL URLWithString:path]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
