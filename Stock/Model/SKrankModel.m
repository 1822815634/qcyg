//
//  SKrankModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKrankModel.h"

@implementation SKrankModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKrankModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
