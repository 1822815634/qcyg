//
//  SKAssetmentInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/27.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAssetmentInfoCell.h"
#import "SKAssetModel.h"

@interface SKAssetmentInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *peiziLab;
@property (weak, nonatomic) IBOutlet UILabel *zichanLab;
@property (weak, nonatomic) IBOutlet UILabel *fengxianLab;
@property (weak, nonatomic) IBOutlet UILabel *keyognLab;

@property (weak, nonatomic) IBOutlet UILabel *dognjieLab;

@end
@implementation SKAssetmentInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
 - (void)setModel:(SKAssetModel *)model
{
    _model = model;
    _fengxianLab.text = model.deposit;
    _keyognLab.text = model.balance;
    _zichanLab.text = model.asset;
    _peiziLab.text = model.order_amt;
      _dognjieLab.text = model.frozen_amt;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
