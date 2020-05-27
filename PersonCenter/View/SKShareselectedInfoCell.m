//
//  SKShareselectedInfoCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKShareselectedInfoCell.h"
#import "SKShareselectModel.h"
@interface SKShareselectedInfoCell ()

@property (nonatomic , weak)UILabel *titleLab;
@property (nonatomic , weak)UILabel *codeLab;
@property (nonatomic , weak)UILabel *acronymLab;
@end

@implementation SKShareselectedInfoCell
- (UILabel *)titleLab
{
    if(!_titleLab){
        WS(weakSelf);
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        label2.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        label2.textAlignment = NSTextAlignmentCenter;
      [self addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset((kScreenWidth - 26)/3);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.height.equalTo(@(30));
            make.width.equalTo(@((kScreenWidth - 26)/3));
        }];
        _titleLab = label2;
    }
    return _titleLab;
}
- (UILabel *)acronymLab
{
    if(!_acronymLab){
        WS(weakSelf);
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        label2.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset((kScreenWidth - 26)/3*2);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.height.equalTo(@(30));
            make.width.equalTo(@((kScreenWidth - 26)/3));
        }];
        
        _acronymLab = label2;
    }
    return _acronymLab;
}
- (UILabel *)codeLab
{
    if(!_codeLab){
        WS(weakSelf);
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        label2.textColor = [UIColor colorWithRed:63/255.0 green:67/255.0 blue:79/255.0 alpha:1];
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.height.equalTo(@(30));
            make.width.equalTo(@((kScreenWidth - 26)/3));
        }];
        _codeLab = label2;
    }
    return _codeLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKShareselectModel *)model
{
    self.codeLab.text = model.code;
    self.acronymLab.text = model.acronym;
    self.titleLab.text = model.title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
