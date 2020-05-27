//
//  SKShareselectModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/15.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKShareselectModel : SKBaseModel

@property (nonatomic , copy)NSString *gid;

@property (nonatomic , copy)NSString * title;

@property (nonatomic , copy)NSString *code;

@property (nonatomic , copy)NSString *acronym;

@property (nonatomic , copy)NSString *amount;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
