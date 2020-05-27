//
//  SKExchangeHistoryCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKExchangeHistoryCell.h"
#import "SKExchangeHistoryModel.h"

@interface SKExchangeHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@end

@implementation SKExchangeHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKExchangeHistoryModel *)model
{
    _model = model;
    _titleLab.text = model.name;
    _scoreLab.text = [NSString stringWithFormat:@"- %@",model.g_cost];
    _timeLab.text = [NSString stringWithFormat:@"%@",model.add_time];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
