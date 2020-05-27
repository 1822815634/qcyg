//
//  SKrealityGoodsModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/4/17.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKrealityGoodsModel : SKBaseModel

@property (nonatomic , copy)NSString *add_time;

@property (nonatomic , copy)NSString * cost;

@property (nonatomic , copy)NSString *middle_img;

@property (nonatomic , copy)NSString *uid;

@property (nonatomic , copy)NSString * name;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
