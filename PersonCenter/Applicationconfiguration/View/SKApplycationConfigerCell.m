//
//  SKApplycationConfigerCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKApplycationConfigerCell.h"
#import "SKapplycationfiguratModel.h"
@interface SKApplycationConfigerCell ()
{
    NSIndexPath *_currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhuibaoBtnContrainHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xuyueBtnConstrainHeight;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImagell;
@property (weak, nonatomic) IBOutlet UIImageView *statueImagell;
@property (weak, nonatomic) IBOutlet UILabel *sumCountLab;
@property (weak, nonatomic) IBOutlet UILabel *kuisunLab;
@property (weak, nonatomic) IBOutlet UILabel *pingcangLab;
@property (weak, nonatomic) IBOutlet UILabel *mangerPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *xuyueButton;
@property (weak, nonatomic) IBOutlet UIButton *zhuibaoButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrainHeight;

@end
@implementation SKApplycationConfigerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupViewWithModel:(SKapplycationfiguratModel *)model index:(NSIndexPath *)index
{
    _currentIndex = index;
   _label1.hidden = YES;
   _label3.hidden = YES;
   _kuisunLab.hidden = YES;
   _mangerPriceLab.hidden = YES;
   _label2.text = @"配资时间";
   _label4.text = @"到期时间";
     if (kScreenWidth < 350) {
     _lineView.hidden = YES;
     }else{
     _lineView.hidden = NO;
     }
  _sumCountLab.text = [NSString stringWithFormat:@"%@",model.money2];
    _pingcangLab.text = [NSString stringWithFormat:@"%@",model.cre_time];
    _timeLab.text = [NSString stringWithFormat:@"%@",model.end];
     if ([model.type integerValue] == 1) {
     _typeImagell.image = showImage(@"月");
     }else{
     _typeImagell.image = showImage(@"日");
     }
}
- (void)initCellWithModel:(SKapplycationfiguratModel *)model
{
    _lineView.hidden = YES;
    _xuyueButton.hidden = YES;
    _zhuibaoButton.hidden = YES;
    _zhuibaoBtnContrainHeight.constant = 0.01;
    _xuyueBtnConstrainHeight.constant = 0.01;
    _bottomConstrainHeight.constant = 15;
    _sumCountLab.text = [NSString stringWithFormat:@"%@",model.money2];
    _kuisunLab.text = [NSString stringWithFormat:@"%@元",model.money3];
    _pingcangLab.text = [NSString stringWithFormat:@"%@元",model.money4];
    _mangerPriceLab.text = [NSString stringWithFormat:@"%@元",model.money5];
    _timeLab.text = model.cre_time;
     if ([model.type integerValue] == 1) {
     _typeImagell.image = showImage(@"月");
     }else{
     _typeImagell.image = showImage(@"日");
     }
}
- (IBAction)xuyueClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKApplycationConfigerCellClick:index:)]) {
        [_vDelegate SKApplycationConfigerCellClick:sender.tag index:_currentIndex];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
