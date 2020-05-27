//
//  SKStrategyCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKStrategyCell.h"
@interface SKStrategyCell ()
{
    NSInteger _currentIndx;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end
@implementation SKStrategyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _joinButton.clipsToBounds = YES;
    _joinButton.layer.cornerRadius = 15;
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 3;
    // Initialization code
}
- (IBAction)joinClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKStrategyCellJoinClickDelegateindex:)]) {
        [_vDelegate SKStrategyCellJoinClickDelegateindex:_currentIndx];
    }
}
- (void)initTypeLab:(NSString *)type index:(NSInteger)tag
{
    _currentIndx = tag;
    _typeLab.text = type;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
