//
//  SKIntegralCouponCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/25.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKIntegralCouponCell.h"
#import "SKCouponView.h"
@interface SKIntegralCouponCell ()
@property (nonatomic , weak)UIScrollView *mainScroller;
@end
@implementation SKIntegralCouponCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.clipsToBounds = YES;
        [self initCouponView];
    }
    return self;
}
- (UIScrollView *)mainScroller
{
    if (!_mainScroller) {
        UIScrollView *scrollerView = [[UIScrollView alloc] init];
        scrollerView.frame = CGRectMake(0, 10, kScreenWidth, 105);
        scrollerView.backgroundColor = [UIColor whiteColor];
        scrollerView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:scrollerView];
        _mainScroller = scrollerView;
    }
    return _mainScroller;
}
- (void)initCouponView
{
    self.mainScroller.contentSize = CGSizeMake(167 * 4, 105);
    for (NSInteger i = 0; i < 4; i ++) {
        SKCouponView *couponView = [SKCouponView initWithinstancetype];
        couponView.frame = CGRectMake(167 * i, 0, 167, 105);
        [self.mainScroller addSubview:couponView];
    }
}
@end
