//
//  SKCashwithdrawaladdCardCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKCashwithdrawaladdCardCell.h"
@interface SKCashwithdrawaladdCardCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation SKCashwithdrawaladdCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setaddCardCellInfo:(NSDictionary *)dict
{
NSString *sting = [dict objectForKey:@"title"];
    if ([sting isKindOfClass:[NSNull class]]) {
   
    }else{
     _titleLab.text = sting;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
