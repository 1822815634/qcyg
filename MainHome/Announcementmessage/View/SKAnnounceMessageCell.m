//
//  SKAnnounceMessageCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAnnounceMessageCell.h"
#import "SKAnnouncementmessageModel.h"

@interface SKAnnounceMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation SKAnnounceMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKAnnouncementmessageModel *)model
{
    _model = model;
    _titleLab.text = model.title;
    _contentLab.text = model.content;
    _timeLab.text = model.cre_time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
