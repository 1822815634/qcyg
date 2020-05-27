//
//  SKTopDaSaiTableViewCell.m
//  Stockallocation
//
//  Created by wuyou on 2019/8/20.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKTopDaSaiTableViewCell.h"
#import "SKStockModel.h"
@interface SKTopDaSaiTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peronLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;

@end

@implementation SKTopDaSaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setupBullraceCellWithmodel:(SKStockModel *)model {
    self.timeLabel.text = [model.title substringFromIndex:4];
    self.dateLabel.text = [NSString stringWithFormat:@"时间:%@-%@",[model.start_time substringWithRange:NSMakeRange(0, 10)],[model.end_time substringWithRange:NSMakeRange(0, 10)]];
    self.peronLabel.text = [NSString stringWithFormat:@"(%@人参赛)", model.renshu];
    if (model.cuid !=0) {
        [_joinBtn setTitle:@"进入比赛" forState:0];
        _joinBtn.tag = 2;
        _outGameBtn.hidden = NO;
    } else {
        [_joinBtn setTitle:@"报名比赛" forState:0];
        _joinBtn.tag = 1;
        _outGameBtn.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)outGameBtnClick:(UIButton *)sender {
    if ([self.vDelegate respondsToSelector:@selector(SKBullracewCellTypeViewClick:)]) {
        [self.vDelegate SKBullracewCellTypeViewClick:sender.tag];
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    if ([self.vDelegate respondsToSelector:@selector(SKBullracewCellTypeViewClick:)]) {
        [self.vDelegate SKBullracewCellTypeViewClick:sender.tag];
    }
}
- (IBAction)moreBtnClick:(id)sender {
    if ([self.vDelegate respondsToSelector:@selector(SKBullracewCellTypeViewClick:)]) {
        [self.vDelegate SKBullracewCellTypeViewClick:3];
    }
}


@end
