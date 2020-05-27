//
//  SKUserInfoView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKUserInfoView.h"
@interface SKUserInfoView ()
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UIButton *focusNumLab;
@property (weak, nonatomic) IBOutlet UIButton *fansNumLab;
@property (weak, nonatomic) IBOutlet UIButton *pointNumLab;
@property (weak, nonatomic) IBOutlet UIButton *rankNumLab;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;

@end
@implementation SKUserInfoView

+ (SKUserInfoView *)instanceSKUserInfoView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKUserInfoView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (IBAction)anwerClick:(UIButton *)sender {
if (_vDelegate && [_vDelegate respondsToSelector:@selector(answerClick:)]) {
    [_vDelegate answerClick:sender.tag];
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _answerButton.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    _answerButton.layer.cornerRadius = 15;
    _focusButton.layer.backgroundColor = [UIColor colorWithHexString:@"#4062f4" andAlpha:1].CGColor;
    _focusButton.layer.cornerRadius = 15;
}
- (void)layoutSubviews
{
    self.width = kScreenWidth - 16;
    self.height = 195;
    [super layoutSubviews];
}
- (void)setUserInfoView:(NSDictionary *)dict
{
    [_rankNumLab setTitle:[NSString stringWithFormat:@"排名 %@",[dict objectForKey:@"ranking"]] forState:0];
     [_focusNumLab setTitle:[NSString stringWithFormat:@"关注%@条",[dict objectForKey:@"gz_num"]] forState:0];
     [_fansNumLab setTitle:[NSString stringWithFormat:@"粉丝%@人",[dict objectForKey:@"fans"]] forState:0];
     [_pointNumLab setTitle:[NSString stringWithFormat:@"观点%@条",[dict objectForKey:@"gd_num"]] forState:0];
}
- (void)setNickName:(NSString *)nickName withType:(NSInteger)type active:(NSInteger)active
{
    _nickNameLab.text = nickName;
    if (type == 1) {
        _answerButton.hidden = YES;
    _focusButton.hidden = YES;
    }else{
        _answerButton.hidden = NO;
    _focusButton.hidden = NO;
    if (active == 1) {
    [_focusButton setTitle:@"已关注" forState:0];
    }else{
    [_focusButton setTitle:@"+ 关注" forState:0];
    }
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
