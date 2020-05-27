//
//  SKAssestdetailModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAssestdetailModel.h"

@implementation SKAssestdetailModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKAssestdetailModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
