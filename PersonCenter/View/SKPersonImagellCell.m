//
//  SKPersonImagellCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKPersonImagellCell.h"

@interface SKPersonImagellCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImagell;

@end
@implementation SKPersonImagellCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setHeadImagellPath:(NSString *)headImagellPath
{
    _headImagellPath = headImagellPath;
if ([headImagellPath hasPrefix:@"http"]) {
 [_headerImagell sd_setImageWithURL:[NSURL URLWithString:headImagellPath]];
}else{
 [_headerImagell sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath, headImagellPath]]];
}

}
- (IBAction)changeImagellClick:(UIButton *)sender {
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(SKPersoninagellChange)]) {
        [_vDelegate SKPersoninagellChange];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
