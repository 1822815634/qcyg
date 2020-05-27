//
//  SKPersonInfoTypeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPersonInfoTypeCell.h"

@interface SKPersonInfoTypeCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *detailInfoLab;

@end

@implementation SKPersonInfoTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTypeLab:(NSString *)type des:(NSString *)desInfo
{
    _typeLab.text = type;
    _detailInfoLab.text = desInfo;
    if ([desInfo isEqualToString:@"0"]) {
    _detailInfoLab.text = @"  审核中";
    }else if ([desInfo isEqualToString:@"1"]){
    _detailInfoLab.text = @"  未通过";
    }else if ([desInfo isEqualToString:@"2"]){
    _detailInfoLab.text = @"  通过";
    }else if([desInfo isEqualToString:@"3"]){
    _detailInfoLab.text = @"  未设置";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
