//
//  SKStockModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKStockModel.h"

@implementation SKStockModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKStockModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
