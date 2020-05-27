//
//  SKCouponModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKCouponModel : SKBaseModel

@property (nonatomic , copy)NSString *state;

@property (nonatomic , copy)NSString *remark;

@property (nonatomic , copy)NSString * time;

@property (nonatomic , assign)NSInteger create_time;

@property (nonatomic , copy)NSString *money;

@property (nonatomic , copy)NSString *uid;

@property (nonatomic , assign)NSInteger type;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
