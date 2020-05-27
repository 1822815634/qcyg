//
//  SKAssetmentSumCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/27.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAssetmentSumCell.h"
#import "SKAssetModel.h"
@interface SKAssetmentSumCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *sumCountLab;
@property (weak, nonatomic) IBOutlet UILabel *yueLab;

@end
@implementation SKAssetmentSumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    _bottomView.layer.cornerRadius = 5;
    _bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0,1.5);
    _bottomView.layer.shadowOpacity = 1;
    _bottomView.layer.shadowRadius = 3;
    // Initialization code
}

- (void)setModel:(SKAssetModel *)model
{
    _model = model;
    _sumCountLab.text = model.net_asset;
    _yueLab.text =model.balance;
}
- (IBAction)tixianClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(tixianClick)]) {
        [_vDelegate tixianClick];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
