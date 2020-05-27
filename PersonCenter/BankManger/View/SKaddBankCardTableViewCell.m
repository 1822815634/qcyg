//
//  SKaddBankCardTableViewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/22.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKaddBankCardTableViewCell.h"

@interface SKaddBankCardTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation SKaddBankCardTableViewCell
- (void)settitle:(NSString *)title
{
   _title.text = title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
