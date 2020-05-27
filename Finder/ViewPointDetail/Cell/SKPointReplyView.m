//
//  SKPointReplyView.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKPointReplyView.h"
@interface SKPointReplyView ()
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;

@end
@implementation SKPointReplyView

+ (SKPointReplyView *)instanceSKPointReplyView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SKPointReplyView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (IBAction)replayClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(replayClick)]) {
        [_vDelegate replayClick];
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _replayBtn.layer.borderColor = [UIColor hexStringToColor:@"eeeeee"].CGColor;
    _replayBtn.layer.borderWidth = 1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
