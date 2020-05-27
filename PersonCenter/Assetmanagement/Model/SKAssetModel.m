//
//  SKAssetModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAssetModel.h"

@implementation SKAssetModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKAssetModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
