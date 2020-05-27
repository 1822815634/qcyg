//
//  SKMyawardInfoCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/4/15.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKMyawardInfoCell.h"
#import "SKLastAwardModel.h"
@interface SKMyawardInfoCell ()
{
NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *paimingLab;
@property (weak, nonatomic) IBOutlet UILabel *awardLab;
@property (weak, nonatomic) IBOutlet UILabel *jiagnliLab;
@property (weak, nonatomic) IBOutlet UIButton *typeStatueBtn;

@end
@implementation SKMyawardInfoCell
- (IBAction)StatueClick:(UIButton *)sender {
if (_vDelegate && [_vDelegate respondsToSelector:@selector(awardredemption:)]) {
[_vDelegate awardredemption:_currentIndex];
}
}
- (void)setModel:(SKLastAwardModel *)model index:(NSInteger)index
{
_currentIndex = index;
    _timeLab.text = [model.hj_time componentsSeparatedByString:@" "][0];
    _paimingLab.text = model.top;
    _awardLab.text = model.earnings;
    _jiagnliLab.text = model.award;
    NSInteger statue = [model.status integerValue];
    if (statue == 0) {
        [_typeStatueBtn setTitle:@"领取" forState:0];
        [_typeStatueBtn setTitleColor:KBlueColor forState:0];
    }else if (statue == 1){
        [_typeStatueBtn setTitle:@"审核中" forState:0];
        [_typeStatueBtn setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
    }else if (statue == 2){
    [_typeStatueBtn setTitle:@"已领取" forState:0];
    [_typeStatueBtn setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
    }else{
        [_typeStatueBtn setTitle:@"已失效" forState:0];
        [_typeStatueBtn setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
