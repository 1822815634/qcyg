//
//  SKAnnouncementmessageModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKAnnouncementmessageModel.h"

@implementation SKAnnouncementmessageModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKAnnouncementmessageModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
