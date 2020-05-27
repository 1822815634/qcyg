//
//  SKUserAcountMessageCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/4.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKUserAcountMessageCell.h"
@interface SKUserAcountMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *sumCountLab;
@property (weak, nonatomic) IBOutlet UILabel *sumRaiseLab;
@property (weak, nonatomic) IBOutlet UILabel *dayRaiseLab;
@property (weak, nonatomic) IBOutlet UILabel *weekRaiseLab;

@end
@implementation SKUserAcountMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setuserAcountInfoWithDic:(NSDictionary *)dict
{
    _sumCountLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"asset"]];
    _sumRaiseLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sum"]];
    _dayRaiseLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"day"]];
    _weekRaiseLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"seven"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
