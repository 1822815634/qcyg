
//
//  SKapplycationfiguratModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKapplycationfiguratModel.h"

@implementation SKapplycationfiguratModel

+(instancetype)initWithDictionary:(NSDictionary *)dict{
    SKapplycationfiguratModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"id"]) {
//       _uid = value;
//    }
}
@end
