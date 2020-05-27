//
//  SKHasFocusCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKHasFocusCell.h"
#import "SKviewPointModel.h"
@interface SKHasFocusCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImagell;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UILabel *relnameLab;
@property (weak, nonatomic) IBOutlet UIButton *fandLab;
@property (weak, nonatomic) IBOutlet UIButton *raiseLab;

@end
@implementation SKHasFocusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKviewPointModel *)model
{
    [_userImagell sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,model.imgurl]] placeholderImage:showImage(@"answer")];
    _nickLab.text = model.nickname;
    _relnameLab.text = model.realname;
    [_fandLab setTitle:[NSString stringWithFormat:@"粉丝 %@ 人",model.fans_num] forState:0];
    [_raiseLab setTitle:[NSString stringWithFormat:@"总收益 %@ ",model.total] forState:0];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
