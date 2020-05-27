//
//  SKInbitationInfoCell.m
//  Stockallocation
//
//  Created by SoWhat on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKInbitationInfoCell.h"

@interface SKInbitationInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *yongjinLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation SKInbitationInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupViewWithCommission:(NSString *)commission count:(NSString *)count
{
    _yongjinLab.text = commission;
    _countLab.text = count;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
