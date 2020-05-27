//
//  SKTradeHistoryModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKTradeHistoryModel : SKBaseModel

@property (nonatomic , copy)NSString *money;

@property (nonatomic , copy)NSString *wid;

@property (nonatomic , copy)NSString *cre_time;

@property (nonatomic , copy)NSString *status;

@property (nonatomic , copy)NSString *title;

@property (nonatomic , copy)NSString *bank;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
