//
//  SKapplycationfiguratModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKapplycationfiguratModel : SKBaseModel

@property (nonatomic , copy)NSString *cre_time;

@property (nonatomic , copy)NSString *money1;
@property (nonatomic , copy)NSString *money2;
@property (nonatomic , copy)NSString *money3;
@property (nonatomic , copy)NSString *money4;
@property (nonatomic , copy)NSString *money5;

@property (nonatomic , copy)NSString *end;

@property (nonatomic , assign)CGFloat money;

@property (nonatomic , assign)NSInteger state;

@property (nonatomic , copy)NSString *cid;

@property (nonatomic , copy)NSString *type;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
