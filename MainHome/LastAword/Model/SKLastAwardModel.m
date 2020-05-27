//
//  SKLastAwardModel.m
//  Stockallocation
//
//  Created by SoWhat on 2019/1/16.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKLastAwardModel.h"

@implementation SKLastAwardModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKLastAwardModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
