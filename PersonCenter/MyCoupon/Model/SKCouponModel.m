//
//  SKCouponModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKCouponModel.h"

@implementation SKCouponModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKCouponModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _uid = value;
    }
}

@end
