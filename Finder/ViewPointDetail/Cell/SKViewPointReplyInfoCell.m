//
//  SKViewPointReplyInfoCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/4/28.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKViewPointReplyInfoCell.h"
#import "SKviewPointInfoModel.h"

@interface SKViewPointReplyInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImagelll;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation SKViewPointReplyInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKviewPointInfoModel *)model
{
_model = model;
[_userImagelll sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,model.bimgurl]]];
_nickName.text = model.brealname;
_contentLab.text = model.content;
_timeLab.text = model.cre_time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
