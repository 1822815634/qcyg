//
//  SKStrategyHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKStrategyHeaderView.h"

@interface SKStrategyHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *descriptInfoLaab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation SKStrategyHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgView.clipsToBounds = YES;
    _bgView.layer.cornerRadius = 3;
}
- (void)setupTile:(NSString *)title detailInfo:(NSString *)detail
{
    _titleLab.text = title;
    _descriptInfoLaab.text = detail;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
