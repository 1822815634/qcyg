//
//  SKResultDetailInfoCell.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKResultDetailInfoCell.h"
#import "SKrankModel.h"

@interface SKResultDetailInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UILabel *earningsLab;
@property (weak, nonatomic) IBOutlet UILabel *awardLab;

@end
@implementation SKResultDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKrankModel *)model
{
    _model = model;
    _nameLab.text = model.realname;
    _earningsLab.text = model.earnings;
    _topLab.text = [NSString stringWithFormat:@"%@",model.top];
    _awardLab.text = model.award;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
