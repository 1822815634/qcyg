//
//  SKLiftingsurplusmodel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/10.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKLiftingsurplusmodel.h"

@implementation SKLiftingsurplusmodel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKLiftingsurplusmodel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


@end
