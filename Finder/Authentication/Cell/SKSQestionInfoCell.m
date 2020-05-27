//
//  SKSQestionInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/26.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKSQestionInfoCell.h"
#import "SKQuestionModel.h"
@interface SKSQestionInfoCell ()
{
NSIndexPath *_currentindex;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaintHeight;
@property (weak, nonatomic) IBOutlet UIButton *questionButton;

@end
@implementation SKSQestionInfoCell
- (IBAction)questionClick:(UIButton *)sender {
if (_vDelegate && [_vDelegate respondsToSelector:@selector(questionSKClick:)]) {
[_vDelegate questionSKClick:_currentindex];
}
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKQuestionModel *)model
{
_model = model;
_titleLab.text = model.nickname;
_contentLab.text = model.content;
}
- (void)setType:(NSString *)type index:(NSIndexPath *)indx
{
_currentindex = indx;
if ([type isEqualToString:@"1"]) {
_questionButton.hidden = NO;
_constaintHeight.constant = 30;
}else{
_questionButton.hidden = YES;
_constaintHeight.constant = 0;
}
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
