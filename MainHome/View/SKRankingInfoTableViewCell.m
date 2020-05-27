//
//  SKRankingInfoTableViewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKRankingInfoTableViewCell.h"
#import "SKLastAwardModel.h"
#import "SKrankModel.h"
@interface SKRankingInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *centerImagell;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *rateLab;
@property (weak, nonatomic) IBOutlet UILabel *rowLab;

@end

@implementation SKRankingInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupViewWithrankModel:(SKrankModel *)model index:(NSIndexPath *)index
{
    _nameLab.text = model.realname;
    _rateLab.text = [NSString stringWithFormat:@"%@",model.shouyi];
//    _rowLab.text = [NSString stringWithFormat:@"%d",index.row + 1];
    _rowLab.text = [model.rank stringValue];
    _rowLab.font = kFont(16);
    _rowLab.textColor = [UIColor hexStringToColor:@"3F434F"];
    if (index.row >= 3) {
        _centerImagell.image = showImage(@"红色");
        _rowLab.textColor = [UIColor hexStringToColor:@"FF6200"];
    }else{
        _centerImagell.image = showImage(@"金色");
        _rowLab.textColor = [UIColor hexStringToColor:@"F43C2B"];
    }
}
- (void)setupViewWithlastAardModel:(SKLastAwardModel *)model index:(NSIndexPath *)index
{
    _nameLab.text = model.realname;
    _rateLab.text = [NSString stringWithFormat:@"%@",model.award];
_rowLab.text = [NSString stringWithFormat:@"%d",index.row + 1];
    _rowLab.textColor = [UIColor hexStringToColor:@"FF6200"];
    if (index.row <3) {
        _centerImagell.image = showImage(@"红色");
        _rowLab.textColor = [UIColor hexStringToColor:@"FF6200"];
    }else{
        _centerImagell.image = showImage(@"金色");
        _rowLab.textColor = [UIColor hexStringToColor:@"F43C2B"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
