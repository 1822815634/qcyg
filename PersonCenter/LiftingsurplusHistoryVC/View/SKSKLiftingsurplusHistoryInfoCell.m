//
//  SKSKLiftingsurplusHistoryInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKSKLiftingsurplusHistoryInfoCell.h"
#import "SKLiftingsurplusmodel.h"
@interface SKSKLiftingsurplusHistoryInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *statueLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation SKSKLiftingsurplusHistoryInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SKLiftingsurplusmodel *)model
{
    _model = model;
    _countLab.text = model.amount;
    _timeLab.text = model.cre_time;
     if ([model.status isEqualToString:@"0"]) {
     _statueLab.text = @"[审核中]";
     }else if ([model.status isEqualToString:@"1"]){
     _statueLab.text = @"[通过]";
     }else{
     _statueLab.text = @"[不通过]";
     }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
