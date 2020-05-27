//
//  SKSexSelectedCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/18.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKSexSelectedCell.h"

@interface SKSexSelectedCell ()
@property (weak, nonatomic) IBOutlet UIButton *WomenBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@end

@implementation SKSexSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)initSexType:(BOOL)type
{
    if (type) {
        [_manBtn setImage:showImage(@"勾选") forState:0];
        [_WomenBtn setImage:showImage(@"未勾选") forState:0];
    }else{
        [_WomenBtn setImage:showImage(@"勾选") forState:0];
        [_manBtn setImage:showImage(@"未勾选") forState:0];
    }
}
- (IBAction)roleClick:(UIButton *)sender {
    if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(changeRoleType:)]) {
        if (sender.tag == 11) {
            [_Vdelegate changeRoleType:YES];
        }else{
            [_Vdelegate changeRoleType:NO];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
