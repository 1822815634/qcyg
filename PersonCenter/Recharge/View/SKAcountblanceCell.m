//
//  SKAcountblanceCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/30.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKAcountblanceCell.h"

@interface SKAcountblanceCell ()
@property (weak, nonatomic) IBOutlet UILabel *acountLab;

@end

@implementation SKAcountblanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setAcountLabText:(NSString *)acount
{
    _acountLab.text = acount;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
