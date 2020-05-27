//
//  SKRankingListTableViewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRankingListTableViewCell.h"

@interface SKRankingListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *rowNoLab;
@property (weak, nonatomic) IBOutlet UILabel *earningsLab;

@end

@implementation SKRankingListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupViewWithrowNo:(NSString *)rowno earnings:(NSString *)earnings
{
    _rowNoLab.text = rowno;
    CGFloat earns = [earnings floatValue];
    earns = earns * 100;
    _earningsLab.text = [NSString stringWithFormat:@"%.1f%%",earns];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
