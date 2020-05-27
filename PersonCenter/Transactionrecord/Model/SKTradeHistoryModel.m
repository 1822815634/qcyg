//
//  SKTradeHistoryModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKTradeHistoryModel.h"

@implementation SKTradeHistoryModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKTradeHistoryModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
