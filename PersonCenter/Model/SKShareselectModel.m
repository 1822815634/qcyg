//
//  SKShareselectModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKShareselectModel.h"

@implementation SKShareselectModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKShareselectModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
