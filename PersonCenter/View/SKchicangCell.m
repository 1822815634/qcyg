//
//  SKchicangCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKchicangCell.h"
#import "SKshareTypeModel.h"

@interface SKchicangCell ()
{
NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *raiseLab;
@property (weak, nonatomic) IBOutlet UILabel *raiseLab2;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;

@end

@implementation SKchicangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceLab.adjustsFontSizeToFitWidth = YES;
    self.raiseLab2.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}
- (void)setShareTypeModel:(SKshareTypeModel *)model index:(NSInteger)index
{
    _currentIndex = index;
    _titleLab.text = model.title;
    _priceLab.text = [NSString stringWithFormat:@"%@",model.now_price];
    _amountLab.text = [NSString stringWithFormat:@"%@",model.amount];
    _raiseLab.text = [NSString stringWithFormat:@"%@",model.loss];
    _raiseLab2.text = [NSString stringWithFormat:@"(%@)",model.rise];
}
- (IBAction)buyOrSellClick:(UIButton *)sender {
     if (_vDelegate &&[_vDelegate respondsToSelector:@selector(SellOrBuyType:index:)]) {
     [_vDelegate SellOrBuyType:sender.tag index:_currentIndex];
     }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
