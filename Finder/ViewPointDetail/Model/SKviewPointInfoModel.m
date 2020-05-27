//
//  SKviewPointInfoModel.m
//  Stockallocation
//
//  Created by SoWhat on 2019/4/28.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKviewPointInfoModel.h"

@implementation SKviewPointInfoModel
+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKviewPointInfoModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
