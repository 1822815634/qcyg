//
//  SKUserCenterHeaderView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKUserCenterHeaderView.h"
#import "SKUserInfoView.h"
@interface SKUserCenterHeaderView ()<SKUserInfoViewanwerClickViewDelegate>

@property (nonatomic , weak)UIView *backView;

@property (nonatomic , weak)SKUserInfoView *infoView;

@property (nonatomic , weak)UIImageView *userImagell;

//@property (nonatomic , weak)UIImageView *VgradeImagell;

@end

@implementation SKUserCenterHeaderView
- (UIView *)backView
{
    if (!_backView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0,0,kScreenWidth,200);
        view.layer.backgroundColor =  [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
        [self.contentView addSubview:view];
        _backView = view;
    }
    return _backView;
}
- (SKUserInfoView *)infoView
{
    if (!_infoView) {
        SKUserInfoView *view = [SKUserInfoView instanceSKUserInfoView];
        view.frame = CGRectMake(8, 45, kScreenWidth - 16, 195);
        view.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        view.vDelegate = self;
        view.layer.cornerRadius = 7;
        view.layer.shadowColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:0.15].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,7.5);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 7.5;
        [self.contentView addSubview:view];
        _infoView = view;
    }
    return _infoView;
}
- (UIImageView *)userImagell
{
    if (!_userImagell) {
        UIImageView *imagell = [[UIImageView alloc] init];
        imagell.frame = CGRectMake((kScreenWidth - 60)/2, 25, 60, 60);
        [self.contentView addSubview:imagell];
        imagell.clipsToBounds = YES;
        imagell.layer.cornerRadius = 30;
        imagell.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClick)];
        [imagell addGestureRecognizer:tap];
        _userImagell = imagell;
    }
    return _userImagell;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self backView];
        [self infoView];
        
//        self.userImagell.image = showImage(@"在线客服");
    }
    return  self;
}
- (void)setupUserInfoHeaderViewWithdic:(NSDictionary *)dict nickName:(NSString *)nickname imagePath:(NSString *)path type:(NSInteger)type active:(NSInteger)active
{
    [self.infoView setNickName:nickname withType:type active:active];
    if (dict) {
        [self.infoView setUserInfoView:dict];
    }
    [self.userImagell sd_setImageWithURL:[NSURL URLWithString:path]];
}
- (void)imageDidClick
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(questionClick:)]) {
        [_vDelegate questionClick:2];
    }
}
- (void)answerClick:(NSInteger)tag
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(questionClick:)]) {
        [_vDelegate questionClick:tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
