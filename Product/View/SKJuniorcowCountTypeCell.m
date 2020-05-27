//
//  SKJuniorcowCountTypeCell.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/8.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKJuniorcowCountTypeCell.h"

@interface SKJuniorcowCountTypeCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation SKJuniorcowCountTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupViewWithtitle:(NSString *)title content:(NSDictionary *)content type:(NSInteger)type index:(NSIndexPath *)index
{
    [self settitleLabTX:index.row dict:content];
    [self setupViewWithTX:title content:title type:type];
}
- (void)setupViewWithTX:(NSString *)title content:(NSString *)content type:(NSInteger)type
{
    _titleLab.text = title;
    if (![content isEqualToString:title]) {
        _contentLab.text = content;
    }
    if (type == 2) {
        _titleLab.textColor = [UIColor hexStringToColor:@"3F434F"];
    }else{
        _titleLab.textColor = [UIColor hexStringToColor:@"3F434F"];
    }
    if (type == 3) {
        _contentLab.textColor = KBlueColor;
    }else{
        _contentLab.textColor = [UIColor hexStringToColor:@"3F434F"];
    }
}
- (void)settitleLabTX:(NSInteger)tag dict:(NSDictionary *)dict
{
    switch (tag) {
        case 0:
             [self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"money2"]]];
            break;
        case 1:
            [self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"money3"]]];
            break;
        case 2:
             [self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"money4"]]];
            break;
        case 3:
           [self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"money1"]]];
            break;
        case 4:
            [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]].length > 7?[self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]]]:[self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"money2"]]];
            break;
            case 5:
             [self setcontentLabTX:[NSString stringWithFormat:@"%@",[dict objectForKey:@"money5"]]];
        default:
            break;
    }
}
- (void)setcontentLabTX:(NSString *)tx
{
    _contentLab.text = tx;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
