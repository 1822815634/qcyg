//
//  SKBannerHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBannerHeaderView.h"
#import <SDCycleScrollView.h>
#import <TXScrollLabelView.h>

@interface SKBannerHeaderView ()< SDCycleScrollViewDelegate , TXScrollLabelViewDelegate>

@property (nonatomic , weak)TXScrollLabelView *scrollLabelView;

@property (nonatomic , weak)SDCycleScrollView *mainScrollerView;

@property (nonatomic , weak)UIView *bgView;

@end

@implementation SKBannerHeaderView
- (SDCycleScrollView *)mainScrollerView
{
    if (!_mainScrollerView) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] init];
        WS(weakSelf);
        view.delegate = weakSelf;
        [weakSelf addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.height.equalTo(@(kScreenWidth * 220 / 375));
        }];
        _mainScrollerView = view;
    }
    return _mainScrollerView;
}
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] init];
        view.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:252/255.0 blue:232/255.0 alpha:1].CGColor;
        [self addSubview:view];
        [self addleftImagell:view];
        [self addrightImagell:view];
        WS(weakSelf);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(weakSelf.mainScrollerView.mas_bottom).offset(0);
            make.height.equalTo(@(0));
        }];
        _bgView = view;
    }
    return _bgView;
}
-(TXScrollLabelView *)scrollLabelView{
    if (!_scrollLabelView) {
        TXScrollLabelView *TXView = [TXScrollLabelView scrollWithTitle:@"前程策略" type:TXScrollLabelViewTypeLeftRight velocity:2.5 options:UIViewAnimationOptionCurveEaseInOut];;
        TXView.scrollSpace = 15;
        TXView.font = kFont(13);
        TXView.scrollLabelViewDelegate = self;
        TXView.textAlignment = NSTextAlignmentCenter;
        TXView.scrollTitleColor = [UIColor colorWithRed:247/255.0 green:148/255.0 blue:29/255.0 alpha:1];
        TXView.layer.cornerRadius = 5;
        TXView.frame = CGRectMake(35, 8, kScreenWidth -60, 24);
        TXView.hidden = YES;
        [self.bgView addSubview:TXView];
        _scrollLabelView = TXView;
    }
    return _scrollLabelView;
}
- (void)addleftImagell:(UIView *)bgView
{
    UIImageView * imagell = [[UIImageView alloc] init];
    imagell.image = showImage(@"gb");
    imagell.frame = CGRectMake(13, 13, 14, 14);
    imagell.hidden = YES;
    [bgView addSubview:imagell];
}
- (void)addrightImagell:(UIView *)bgView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:showImage(@"right") forState:0];
    bgView.hidden = YES;
    button.frame = CGRectMake(kScreenWidth - 20,10, 20, 20);
    button.tag = 1206;
    [button addTarget:self action:@selector(Tap) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
}
- (void)setupViewWithimageList:(NSArray *)list txString:(NSString *)tx
{
    self.mainScrollerView.imageURLStringsGroup = list;
    self.scrollLabelView.scrollTitle = tx;
    [self.scrollLabelView beginScrolling];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [self dideselectedAtindex:index];
}
- (void)Tap
{
    [self checketMore:1206];
}
- (void)checketMore:(NSInteger )tag
{
     [self dideselectedAtindex:tag];
}
- (void)dideselectedAtindex:(NSInteger)index
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKBannerHeaderViewDidselectedAtindex:)]) {
        [_vDelegate SKBannerHeaderViewDidselectedAtindex:index];
    }
}
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index
{
    [self Tap];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
