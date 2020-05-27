//
//  SKchengjiaoCell.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKchengjiaoCell.h"
#import "SKshareTypeModel.h"
@interface SKchengjiaoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *maimaiLab;

@end
@implementation SKchengjiaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SKshareTypeModel *)model
{
    _model = model;
    _titleLab.text = model.title;
    _codeLab.text = [NSString stringWithFormat:@"%@",model.code];
    _countLab.text = [NSString stringWithFormat:@"%@",model.amount];
    _priceLab.text = [NSString stringWithFormat:@"%@",model.price];
    _maimaiLab.text = model.info;
    _amountLab.text = [NSString stringWithFormat:@"%@",model.money] ;
    _timeLab.text = [SKchengjiaoCell getOvertime:model.time];
}

+ (NSString*)getOvertime:(NSString*)mStr{
    NSTimeInterval interval    =[mStr doubleValue];
    NSDate *date              = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString      = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
