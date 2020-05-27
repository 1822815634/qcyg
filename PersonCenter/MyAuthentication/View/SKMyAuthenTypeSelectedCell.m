//
//  SKMyAuthenTypeSelectedCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/28.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKMyAuthenTypeSelectedCell.h"
@interface SKMyAuthenTypeSelectedCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end
@implementation SKMyAuthenTypeSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTypeLabelText:(NSString *)text content:(NSString *)content index:(NSIndexPath *)index
{
      _typeLab.text = text;
      if (content.length > 1) {
      _contentLab.text = content;
      }else{
      switch (index.row) {
          case 0:
          _contentLab.text = @"请点击选择资格证书";
          break;
          case 1:
          _contentLab.text = @"请点击选择所在岗位";
          break;
          case 3:
          _contentLab.text = @"请点击选择从业年限";
          break;
          default:
          break;
      }
}

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
