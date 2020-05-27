//
//  SKshareTypeModel.h
//  Stockallocation
//
//  Created by SoWhat on 2019/3/23.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKshareTypeModel : SKBaseModel

@property (nonatomic , copy)NSString *rid;

@property (nonatomic , copy)NSString * title;

@property (nonatomic , copy)NSString *time;

@property (nonatomic , copy)NSString *info;

@property (nonatomic , copy)NSString *price;

@property (nonatomic , copy)NSString * amount;

@property (nonatomic , copy)NSString *money;

@property (nonatomic , copy)NSString *code;

@property (nonatomic , copy)NSString *trade;

@property (nonatomic , copy)NSString *status;

@property (nonatomic , copy)NSString *gid;

@property (nonatomic , copy)NSString *now_price;

@property (nonatomic , copy)NSString *rise;

@property (nonatomic , copy)NSString *loss;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
