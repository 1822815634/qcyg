//
//  SKTopListTableViewCell.m
//  Stockallocation
//
//  Created by wuyou on 2019/8/20.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKTopListTableViewCell.h"

@interface SKTopListTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *lefImageV;
@property (weak, nonatomic) IBOutlet UILabel *numerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnLabel;

@end

@implementation SKTopListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numerLabel.layer.cornerRadius = 15;
    self.numerLabel.layer.masksToBounds = YES;
    self.numerLabel.layer.borderColor = KBlueColor.CGColor;
    self.numerLabel.layer.borderWidth = 2;
    self.iconImageView.layer.cornerRadius = 24;
    self.iconImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setDataWithNum:(NSString *)num headImage:(NSString *)image Name:(NSString *)name earn:(NSString *)earn {
    self.numerLabel.text = num;
    self.nameLabel.text = [NSString stringWithFormat:@"%@(我)",name];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,image]]];
    CGFloat earns = [earn floatValue];
    earns = earns * 100;
    self.earnLabel.text = [NSString stringWithFormat:@"月收益%.1f%%",earns];
    
}

- (void)setDataWithModel:(SKrankModel *)model Section:(NSInteger)section{
    self.lefImageV.hidden = section>3?1:0;
    self.numerLabel.hidden = section>3?0:1;
    if (section <=3) {
        self.lefImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",section]];
    }
    self.numerLabel.text = [model.rank stringValue];
    self.nameLabel.text = model.realname;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,model.u_img]]];
    self.earnLabel.text = [NSString stringWithFormat:@"月收益%@",model.shouyi];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
