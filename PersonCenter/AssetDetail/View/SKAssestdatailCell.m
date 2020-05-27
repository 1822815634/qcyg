//
//  SKAssestdatailCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAssestdatailCell.h"
#import "SKAssestdetailModel.h"

@interface SKAssestdatailCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *shouruLab;
@property (weak, nonatomic) IBOutlet UILabel *zhichuLab;
@property (weak, nonatomic) IBOutlet UILabel *yueLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation SKAssestdatailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKAssestdetailModel *)model
{
    _model = model;
    _titleLab.text = model.info;
    _timeLab.text = model.cre_time;
    _yueLab.text = [NSString stringWithFormat:@"%@",model.balance];
    _zhichuLab.text = [NSString stringWithFormat:@"%@",model.expend];
    _shouruLab.text = [NSString stringWithFormat:@"%@",model.income];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
