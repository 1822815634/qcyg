//
//  SKchetuoCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKchetuoCell.h"
#import "SKshareTypeModel.h"
@interface SKchetuoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *chegnjiaoLab;
@property (weak, nonatomic) IBOutlet UILabel *statueLab;
@property (weak, nonatomic) IBOutlet UILabel *maimaiLab;
@property (weak, nonatomic) IBOutlet UILabel *chedanLab;

@end
@implementation SKchetuoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKshareTypeModel *)model
{
    _model = model;
    _titleLab.text = model.title;
    _codeLab.text = [NSString stringWithFormat:@"%@",model.code];
    _countLab.text = [NSString stringWithFormat:@"%@",model.amount];
    _priceLab.text = [NSString stringWithFormat:@"%@",model.price];
    _maimaiLab.text = model.info;
    _amountLab.text = [NSString stringWithFormat:@"%@",model.money] ;
    _timeLab.text = model.time;
    _statueLab.text = model.status;
    _chegnjiaoLab.text = [NSString stringWithFormat:@"%@",model.trade];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
