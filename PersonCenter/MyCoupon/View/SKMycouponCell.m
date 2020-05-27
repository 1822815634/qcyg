//
//  SKMycouponCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKMycouponCell.h"
#import "SKCouponModel.h"
@interface SKMycouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *yh_moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *statuesLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconstrainHeight;

@end

@implementation SKMycouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKCouponModel *)model
{
    _model = model;
    _yh_moneyLab.text = [NSString stringWithFormat:@"%@",model.money];
    _timeLab.text = [NSString stringWithFormat:@"有效期至%@",model.time];
    if ([model.state integerValue] == 0) {
        _statuesLab.text = @"配资状态：可使用";
        _yh_moneyLab.textColor = [UIColor hexStringToColor:@"FF0000"];
        _typeLab.textColor = [UIColor hexStringToColor:@"FF0000"];
    }else if ([model.state integerValue] == 1){
         _statuesLab.text = @"配资状态：已使用";
        _yh_moneyLab.textColor = [UIColor hexStringToColor:@"838383"];
        _typeLab.textColor = [UIColor hexStringToColor:@"838383"];
    }else{
         _statuesLab.text = @"配资状态：已过期";
        _yh_moneyLab.textColor = [UIColor hexStringToColor:@"838383"];
        _typeLab.textColor = [UIColor hexStringToColor:@"838383"];
    }
    if (model.type == 1) {
        _typeLab.text = @"厘";
    }else{
        _typeLab.text = @"元";
    }
    if (model.remark.length > 1) {
        _topconstrainHeight.constant = 25;
    }else{
        _topconstrainHeight.constant = 40;
    }
    _rankLab.text = model.remark;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
