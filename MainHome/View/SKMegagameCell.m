//
//  SKMegagameCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKMegagameCell.h"
@interface SKMegagameCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UILabel *joinStatuesLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *starTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;

@end
@implementation SKMegagameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 3;
    _joinButton.clipsToBounds = YES;
    _joinButton.layer.cornerRadius = 15;
    _joinStatuesLab.layer.borderWidth = 0.5;
    _joinStatuesLab.layer.borderColor = [UIColor colorWithRed:247/255.0 green:148/255.0 blue:29/255.0 alpha:1].CGColor;
    _joinStatuesLab.clipsToBounds = YES;
    _joinStatuesLab.layer.cornerRadius = 2;
    // Initialization code
}
- (IBAction)JoinClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKMegagameCellJoinClickDelegate)]) {
        [_vDelegate SKMegagameCellJoinClickDelegate];
    }
}
- (void)setUpViewWithDic:(NSDictionary *)dict
{
    _titleLab.text = [dict objectForKey:@"title"];
    _endTimeLab.text = [NSString stringWithFormat:@"结束时间 %@",[dict objectForKey:@"end"]];
    _starTimeLab.text = [NSString stringWithFormat:@"开始时间 %@",[dict objectForKey:@"start"]];
    _numLab.text = [NSString stringWithFormat:@"共有%@人参与",[dict objectForKey:@"num"]];
    _countLab.text = [dict objectForKey:@"stage"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
