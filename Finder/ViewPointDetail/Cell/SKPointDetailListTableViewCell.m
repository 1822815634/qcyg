//
//  SKPointDetailListTableViewCell.m
//  Stockallocation
//
//  Created by wuyou on 2019/8/13.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKPointDetailListTableViewCell.h"

@implementation SKPointDetailListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc]init];
        self.iconImageView.layer.cornerRadius = 10;
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.iconImageView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(self.contentView.mas_top).offset(20);
            make.width.height.mas_equalTo(40);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.textColor = [UIColor hexStringToColor:@"333333"];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
            make.top.mas_equalTo(self.iconImageView);
            make.height.mas_equalTo(20);
        }];
//
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = [UIColor hexStringToColor:@"999999"];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
            make.top.mas_equalTo(self.nameLabel.mas_bottom);
            make.height.mas_equalTo(20);
        }];
//
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.textColor = [UIColor hexStringToColor:@"333333"];
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(20);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    return self;
}

- (void)setDataWithModel:(SKPointDetailListModelResponse *)data {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,data.bimgurl]]];
    self.nameLabel.text = data.brealname;
    self.timeLabel.text = data.cre_time;
    self.contentLabel.text = data.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
