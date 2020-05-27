//
//  SKInvitationCell.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKInvitationCell.h"
#import "SKInvationModel.h"
@interface SKInvitationCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *peiziLab;
@property (weak, nonatomic) IBOutlet UILabel *yueLab;

@end

@implementation SKInvitationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SKInvationModel *)model
{
    _model = model;
    _nameLab.text = model.nickname;
    _phoneLab.text = model.tel;
    _timeLab.text = model.cre_time;
    _peiziLab.text = [NSString stringWithFormat:@"%@",model.money];
    _yueLab.text = [NSString stringWithFormat:@"%@",model.balance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
