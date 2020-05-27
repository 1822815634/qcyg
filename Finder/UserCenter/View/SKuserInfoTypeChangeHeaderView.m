//
//  SKuserInfoTypeChangeHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/21.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKuserInfoTypeChangeHeaderView.h"
#import "SKOperaHeaderView.h"
#import "SKBullraceheaderView.h"
@interface SKuserInfoTypeChangeHeaderView ()<SKOperaHeaderViewTypeViewDelegate , SKBullraceheaderViewDelegate>
{
    NSInteger _currentIndx;
}
@property (nonatomic , weak)SKOperaHeaderView *headerView;
@property (nonatomic , weak)SKBullraceheaderView *Thearderview;
@end

@implementation SKuserInfoTypeChangeHeaderView
- (SKBullraceheaderView *)Thearderview
{
    if (!_Thearderview) {
        SKBullraceheaderView *view = [[SKBullraceheaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 45);
        view.vDelegate = self;
        [self addSubview:view];
        _Thearderview = view;
    }
    return _Thearderview;
}
- (SKOperaHeaderView *)headerView
{
    if (!_headerView) {
        SKOperaHeaderView *view = [[SKOperaHeaderView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, 45);
        view.vDelegate = self;
        [self addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

- (void)infoTypeChangeHeaderView:(NSInteger)index title:(NSArray *)title
{
    if (title.count > 2) {
        [self.headerView setupView:index titleArr:title];
    }else{
        [self.Thearderview setupView:index titleArr:title];
    }
    _currentIndx = index;
}
- (void)SKOperaHeaderViewTypeViewClick:(NSInteger)tag
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(infoChangeinfoChangeHeadertype:)]) {
        [_vDelegate infoChangeinfoChangeHeadertype:tag];
    }
}
- (void)SKBullraceheaderViewTypeViewClick:(NSInteger)tag {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(infoChangeinfoChangeHeadertype:)]) {
        [_vDelegate infoChangeinfoChangeHeadertype:tag];
    }
}

@end
