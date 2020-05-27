//
//  SKJingXuanCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/4.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKJingXuanCell.h"
#import "SKviewPointModel.h"

@interface SKJingXuanCell ()
{
    NSIndexPath *_currentIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *centerImagell;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UIImageView *gradeImagell;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *dianzanLab;
@property (weak, nonatomic) IBOutlet UILabel *huifuLab;

@end

@implementation SKJingXuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_centerImagell.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_centerImagell.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = _centerImagell.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    _centerImagell.layer.mask = maskLayer;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerimageClick)];
    _centerImagell.userInteractionEnabled = YES;
    [_centerImagell addGestureRecognizer:tap];
    _focusBtn.layer.borderColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    _focusBtn.clipsToBounds = YES;
    _focusBtn.layer.cornerRadius = 8;
    _focusBtn.layer.borderWidth = 1;
    _contentLab.numberOfLines = 2;
    
}
- (void)setviewPointModel:(SKviewPointModel *)model index:(NSIndexPath *)index type:(NSInteger)type
{
    NSString*path = [NSString stringWithFormat:@"%@%@",ServerPath,model.imgurl];
    _currentIndex = index;
    _nickLab.text = model.author;
    _titleLab.text = model.title;
    _contentLab.text = model.content;
    _timeLab.text = model.create_time;
    _dianzanLab.text = [NSString stringWithFormat:@"%ld",(long)model.z_sum];
    _huifuLab.text = [NSString stringWithFormat:@"%ld",(long)model.w_sum];
    [_centerImagell sd_setImageWithURL:[NSURL URLWithString:path]];
    if (model.active == 1) {
        [_focusBtn setTitle:@" 已关注 " forState:0];
    }else{
         [_focusBtn setTitle:@" +关注 " forState:0];
    }
    if (type == 1) {
        _focusBtn.hidden = YES;
        _reportBtn.hidden = YES;
    }else{
        _focusBtn.hidden = NO;
        _reportBtn.hidden = NO;
    }
}
- (IBAction)reportButton:(id)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(reoprtBtnClick)]) {
        [_vDelegate reoprtBtnClick];
    }
}

- (IBAction)focuButton:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(poinViewtouchEndClick:)]) {
        [_vDelegate poinViewtouchEndClick:_currentIndex];
    }
}

- (IBAction)zanOrreplyClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(zanOrreplyClickWithTag:index:)]) {
        [_vDelegate zanOrreplyClickWithTag:sender.tag index:_currentIndex.row];
    }
}

- (void)headerimageClick
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(userimagellTouchClick:)]) {
        [_vDelegate userimagellTouchClick:_currentIndex];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
