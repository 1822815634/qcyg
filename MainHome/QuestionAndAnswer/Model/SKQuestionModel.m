//
//  SKQuestionModel.m
//  Stockallocation
//
//  Created by SoWhat on 2019/1/21.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKQuestionModel.h"

@implementation SKQuestionModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKQuestionModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
