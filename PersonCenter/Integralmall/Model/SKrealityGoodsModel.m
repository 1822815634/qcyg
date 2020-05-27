//
//  SKrealityGoodsModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/4/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKrealityGoodsModel.h"

@implementation SKrealityGoodsModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKrealityGoodsModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _uid = value;
    }
}

@end
