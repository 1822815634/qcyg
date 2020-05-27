//
//  SKExchangeHistoryModel.m
//  Stockallocation
//
//  Created by SoWhat on 2019/1/10.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKExchangeHistoryModel.h"

@implementation SKExchangeHistoryModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKExchangeHistoryModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
//            _Rid = value;
    }
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end
