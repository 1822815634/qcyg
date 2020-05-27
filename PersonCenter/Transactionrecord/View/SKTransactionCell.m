//
//  SKTransactionCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/21.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKTransactionCell.h"
#import "SKTradeHistoryModel.h"
@interface SKTransactionCell ()
@property (weak, nonatomic) IBOutlet UILabel *TypeLab;
@property (weak, nonatomic) IBOutlet UILabel *statuesLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end
@implementation SKTransactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTransactionWithTag:(NSInteger)tag model:(SKTradeHistoryModel *)model
{
    if(tag == 3){
          _TypeLab.text = model.bank;
        _countLab.text = [NSString stringWithFormat:@"-%@",model.money];
    }else{
        _TypeLab.text = model.title;
        _countLab.text = [NSString stringWithFormat:@"+%@",model.money];
    }
    
    _timeLab.text = model.cre_time;
    
    if ([model.status isEqualToString:@"0"]) {
        _statuesLab.text = @"[审核中]";
        _countLab.textColor = [UIColor hexStringToColor:@"B9C0C6"];
    }else if ([model.status isEqualToString:@"1"]){
        _statuesLab.text = @"[通过]";
          _countLab.textColor = [UIColor hexStringToColor:@"F43C2B"];
    }else{
        _statuesLab.text = @"[不通过]";
        _countLab.textColor = [UIColor hexStringToColor:@"B9C0C6"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
