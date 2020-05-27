//
//  SKchicangTypeChnageCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKchicangTypeChnageCell.h"
@interface SKchicangTypeChnageCell ()
@property (weak, nonatomic) IBOutlet UIButton *chicangBtn;
@property (weak, nonatomic) IBOutlet UIButton *weituoBtn;
@property (weak, nonatomic) IBOutlet UIButton *chengjiaoBtn;

@end
@implementation SKchicangTypeChnageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self changeButtonborderWithandColor:_chicangBtn];
    [self changeButtonborderWithandColor:_weituoBtn];
    [self changeButtonborderWithandColor:_chengjiaoBtn];
}
- (void)changeButtonborderWithandColor:(UIButton *)btn
{
    btn.layer.borderColor = [UIColor hexStringToColor:@"eeeeee"].CGColor;
    btn.layer.borderWidth = 1;
}
- (IBAction)changTypeClick:(UIButton *)sender {
    [self changeTypeBtnBackgradColor:sender.tag];
    if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(SKchicangTypeChnageCellTypeClickTag:)]) {
        [_Vdelegate SKchicangTypeChnageCellTypeClickTag:sender.tag];
    }
}
- (void)skchangeType:(NSInteger)type
{
    [self changeTypeBtnBackgradColor:type];
}
- (void)changeTypeBtnBackgradColor:(NSInteger)tag
{
    for (NSInteger i = 1; i <= 3; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i];
        if (tag == i) {
            [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [btn setTitleColor:[UIColor hexStringToColor:@"F43C2B"] forState:0];
        }else{
              [btn setTitleColor:[UIColor hexStringToColor:@"838383"] forState:0];
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
