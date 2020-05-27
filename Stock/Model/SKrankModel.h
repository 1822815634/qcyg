//
//  SKrankModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKrankModel : SKBaseModel

@property (nonatomic , copy)NSString *earnings;

@property (nonatomic , copy)NSString *realname;

@property (nonatomic , copy)NSString *shouyi;

@property (nonatomic , copy)NSString *award;

@property (nonatomic , copy)NSString *uid;

@property (nonatomic , copy)NSString *top;

@property (nonatomic , strong)NSNumber *rank;

@property (nonatomic , )NSString *u_img;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
