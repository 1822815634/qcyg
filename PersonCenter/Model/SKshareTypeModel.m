//
//  SKshareTypeModel.m
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKshareTypeModel.h"

@implementation SKshareTypeModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKshareTypeModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
