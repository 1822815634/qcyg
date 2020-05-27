//
//  SKLastAwardModel.h
//  Stockallocation
//
//  Created by SoWhat on 2019/1/16.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKLastAwardModel : SKBaseModel

@property (nonatomic , copy)NSString *earnings;

@property (nonatomic , copy)NSString * award;

@property (nonatomic , copy)NSString * top;

@property (nonatomic , assign)NSInteger uid;

@property (nonatomic , copy)NSString *realname;

@property (nonatomic , copy)NSString *hj_id;

@property (nonatomic , copy)NSString * validity;

@property (nonatomic , copy)NSString * status;

@property (nonatomic , copy)NSString * hj_time;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
