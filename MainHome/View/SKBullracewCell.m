//
//  SKBullracewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBullracewCell.h"
#import "SKStockModel.h"
@interface SKBullracewCell ()
{
    NSIndexPath *_currentIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *joinAndoutRaceButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *statueButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *joinRaceButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrainHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *joinRaceHeight;

@end

@implementation SKBullracewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _joinAndoutRaceButton.clipsToBounds = YES;
    _joinAndoutRaceButton.layer.cornerRadius = 15;
    _joinRaceButton.clipsToBounds = YES;
    _joinRaceButton.layer.cornerRadius = 15;
}

- (void)setupBullraceCellWithmodel:(SKStockModel *)model index:(NSIndexPath *)index
{
    _currentIndex = index;
    _countLab.text = model.renshu;
    _timeLab.text = [NSString stringWithFormat:@"截止日期：%@",model.end_time];
    _titleLab.text = model.title;
    [_joinAndoutRaceButton setTitle:@"报名比赛" forState:0];
   _joinRaceButton.hidden = YES;
  _topConstrainHeight.constant = 17;
  _joinRaceHeight.constant = 0;
    if (model.status == 0) {
        [_statueButton setImage:showImage(@"进行中") forState:0];
        if (model.cuid != 0) {
             [_joinAndoutRaceButton setTitle:@"退出比赛" forState:0];
            _joinRaceButton.hidden = NO;
            _topConstrainHeight.constant = 52;
            _joinRaceHeight.constant = 31;
        }else{
        }
    }else if (model.status == 2){
            [_statueButton setImage:showImage(@"已结束") forState:0];
            [_joinAndoutRaceButton setTitle:@"查看结果" forState:0];
    }else{
            [_statueButton setImage:showImage(@"等待开始") forState:0];
    }
}

- (IBAction)ruleClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKBullracewCellTypeViewClick:index:)]) {
        [_vDelegate SKBullracewCellTypeViewClick:sender.tag index:_currentIndex];
    }
}
- (IBAction)JoinClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKBullracewCellTypeViewClick:index:)]) {
        [_vDelegate SKBullracewCellTypeViewClick:sender.tag index:_currentIndex];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
