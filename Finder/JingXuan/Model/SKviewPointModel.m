//
//  SKviewPointModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKviewPointModel.h"

@implementation SKviewPointModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKviewPointModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    model.contentHeight = [self getStringHeightWithText:model.content viewWidth:kScreenWidth - 30] + 96 + 35;
    return model;
}

+ (CGFloat)getStringHeightWithText:(NSString *)text viewWidth:(CGFloat)width {
    NSDictionary *attrs = @{NSFontAttributeName :kFont(15)};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    return  ceilf(size.height)>25?ceilf(size.height):25;
}

@end
