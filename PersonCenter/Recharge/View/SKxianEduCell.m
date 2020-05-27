//
//  SKxianEduCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKxianEduCell.h"
@interface SKxianEduCell ()

@property (weak, nonatomic) IBOutlet UILabel *TypeLab;
@end
@implementation SKxianEduCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupxianEdu:(NSString *)type
{
    _TypeLab.text = type;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
