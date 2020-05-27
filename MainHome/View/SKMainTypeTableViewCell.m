//
//  SKMainTypeTableViewCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/11/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKMainTypeTableViewCell.h"

@interface SKMainTypeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image4;

@end

@implementation SKMainTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)initWithSKMaintypeView:(NSArray *)imagePathList
{
    for (NSInteger i = 0; i < imagePathList.count; i ++) {
        UIImageView *typeImage = (UIImageView *)[self.contentView viewWithTag:101 + i];
        typeImage.image = showImage(imagePathList[i]);
    }
}
- (IBAction)typeClick:(UIButton *)sender {
  if(_vDelegate && [_vDelegate respondsToSelector:@selector(SKMainTypeTableViewCellTypeClickDelegate:)])
  {
      [_vDelegate SKMainTypeTableViewCellTypeClickDelegate:sender.tag];
  }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
