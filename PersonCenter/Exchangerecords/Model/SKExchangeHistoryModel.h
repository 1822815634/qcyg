//
//  SKExchangeHistoryModel.h
//  Stockallocation
//
//  Created by SoWhat on 2019/1/10.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKExchangeHistoryModel : SKBaseModel

@property (nonatomic , copy)NSString * status;

@property (nonatomic , copy)NSString * g_cost;

@property (nonatomic , copy)NSString *name;

@property (nonatomic , copy)NSString *add_time;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
