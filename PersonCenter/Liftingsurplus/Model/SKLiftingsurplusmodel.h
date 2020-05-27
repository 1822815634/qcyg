//
//  SKLiftingsurplusmodel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/10.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKLiftingsurplusmodel : SKBaseModel

@property (nonatomic , copy)NSString* amount;

@property (nonatomic , copy)NSString* cre_time;

@property (nonatomic ,  copy)NSString *status;

@property (nonatomic , copy)NSString* mid;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
