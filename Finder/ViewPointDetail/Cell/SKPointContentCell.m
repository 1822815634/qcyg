//
//  SKPointContentCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKPointContentCell.h"
@interface SKPointContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end
@implementation SKPointContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setcontentLabtext:(NSString *)content
{   
    _contentLab.text = content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
