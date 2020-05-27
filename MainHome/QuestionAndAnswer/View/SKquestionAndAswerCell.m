//
//  SKquestionAndAswerCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/1/21.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKquestionAndAswerCell.h"
#import "SKQuestionModel.h"

@interface SKquestionAndAswerCell ()
{
   NSInteger _currentIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *anwerLab;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UIImageView *userImagell;

@end

@implementation SKquestionAndAswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIndex:(NSInteger)index
{
      _index = index;
      _currentIndex = index;
}
- (void)setModel:(SKQuestionModel *)model
{
    _model = model;
    _nickLab.text = model.nickname;
    _titleLab.text = model.content;
    _contentLab.text = model.hdcontent;
    _anwerLab.text = model.hd_nickname;
    [_userImagell sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,model.hd_img]] placeholderImage:showImage(@"answer")];
    _contentLab.hidden = YES;
    _anwerLab.hidden = YES;
    _userImagell.hidden = YES;
}
- (IBAction)imageTouchClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(touchHeaderImagellClick:)]) {
    [_vDelegate touchHeaderImagellClick:_currentIndex];
    }
}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    [_nickLab sizeToFit];
//    [_titleLab sizeToFit];
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
