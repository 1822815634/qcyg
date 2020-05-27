//
//  SKJuniorAgreeProtocolCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKJuniorAgreeProtocolCell.h"
@interface SKJuniorAgreeProtocolCell ()
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@end
@implementation SKJuniorAgreeProtocolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)changeCommitBtntitle:(NSInteger)tag ret:(BOOL)ret
{
    if(tag == 1){
        [_protocolBtn setTitle:@"《初级牛人合作协议》" forState:0];
    }else{
        [_protocolBtn setTitle:@"《天天策略合作协议》" forState:0];
    }
    [self setaggretBtnBack:ret];
}
- (void)setaggretBtnBack:(BOOL)ret
{
    if (ret) {
        [_agreeBtn setImage:showImage(@"勾选") forState:0];
    }else{
          [_agreeBtn setImage:showImage(@"未勾选") forState:0];
    }
}
- (IBAction)noticeClick:(UIButton *)sender {
    [self changeBtnType:sender.tag - 500];
}


- (IBAction)protocolClick:(UIButton *)sender {
    [self changeBtnType:sender.tag - 500];
}
- (IBAction)agreeClick:(UIButton *)sender {
   [self changeBtnType:sender.tag - 500];
}
- (IBAction)commitClick:(UIButton *)sender {
    [self changeBtnType:sender.tag - 500];
}
- (void)changeBtnType:(NSInteger)tag
{
    if (_vDelegate && [_vDelegate respondsToSelector:@selector(selectedbButtonType:)]) {
        [_vDelegate selectedbButtonType:tag];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
