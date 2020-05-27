//
//  SKInvationModel.m
//  Stockallocation
//
//  Created by SoWhat on 2019/1/13.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKInvationModel.h"

@implementation SKInvationModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKInvationModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
