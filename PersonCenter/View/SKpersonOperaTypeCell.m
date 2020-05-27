//
//  SKpersonOperaTypeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import "SKpersonOperaTypeCell.h"

@interface SKpersonOperaTypeCell ()
{
    NSIndexPath *_currentIndex;
}
@property (weak, nonatomic) IBOutlet UIImageView *imagell4;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@end

@implementation SKpersonOperaTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick1:(UIButton *)sender {
    if (_Vdelegate && [_Vdelegate respondsToSelector:@selector(SKpersonOperaTypeCellTypeClickIndex:tag:)]) {
        [_Vdelegate SKpersonOperaTypeCellTypeClickIndex:_currentIndex.section tag:sender.tag];
    }
}

- (void)initSkpersonOperaTypeCell:(NSArray *)titleArr imageArr:(NSArray *)imageArr hidden:(BOOL)ret title:(NSString *)title index:(NSIndexPath *)index
{
    _currentIndex = index;
    _imagell4.hidden = ret;
    _button4.hidden = ret;
    _label4.hidden = ret;
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        UIImageView *image = (UIImageView *)[self.contentView viewWithTag:11 + i];
        image.image = showImage(imageArr[i]);
        UILabel *lab = (UILabel *)[self.contentView viewWithTag:21 + i];
        lab.text = titleArr[i];
    }
    _titleLab.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
