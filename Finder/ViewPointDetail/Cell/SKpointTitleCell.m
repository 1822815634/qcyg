//
//  SKpointTitleCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKpointTitleCell.h"
@interface SKpointTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;

@end
@implementation SKpointTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setPointTitleCell:(NSString *)title leftLab:(NSString *)left rightLab:(NSString *)right
{
    _titleLab.text = title;
    _leftLab.text = left;
    _rightLab.text = right;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
