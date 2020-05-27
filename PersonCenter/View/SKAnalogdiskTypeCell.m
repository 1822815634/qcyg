//
//  SKAnalogdiskTypeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/16.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAnalogdiskTypeCell.h"
#import "SKOperaHeaderView.h"

@interface SKAnalogdiskTypeCell ()<SKOperaHeaderViewTypeViewDelegate>

@property (nonatomic , weak)SKOperaHeaderView *headerView;

@end

@implementation SKAnalogdiskTypeCell
- (SKOperaHeaderView *)headerView
{
    if (!_headerView) {
        SKOperaHeaderView *view = [[SKOperaHeaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 44);
        view.vDelegate = self;
        [self addSubview:view];
        _headerView = view;
    }
    return _headerView;
}
- (void)setupViewwithTag:(NSInteger)tag titleArr:(NSArray *)arr
{
    [self.headerView setupView:tag titleArr:arr];
}
- (void)SKOperaHeaderViewTypeViewClick:(NSInteger)tag
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKAnalogdiskTypeCellTypeViewClick:)]) {
        [_vDelegate SKAnalogdiskTypeCellTypeViewClick:tag];
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
