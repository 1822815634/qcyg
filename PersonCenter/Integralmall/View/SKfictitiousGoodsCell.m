//
//  SKfictitiousGoodsCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/25.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKfictitiousGoodsCell.h"
#import "SKrealityGoodsModel.h"
@interface SKfictitiousGoodsCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImagell;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@end
@implementation SKfictitiousGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.layer.borderWidth = 1;
    _bgView.layer.cornerRadius = 2;
    _bgView.clipsToBounds = YES;
    _bgView.layer.borderColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0].CGColor;
}
- (void)setModel:(SKrealityGoodsModel *)model
{
    _titleLab.text = model.name;
    [_centerImagell sd_setImageWithURL:[NSURL URLWithString:model.middle_img]];
    _desLab.text = [NSString stringWithFormat:@"%@",model.cost];
}
@end
