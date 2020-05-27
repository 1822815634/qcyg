//
//  SKAssestdetailModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/11.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"


@interface SKAssestdetailModel : SKBaseModel

@property (nonatomic , assign)CGFloat money;

@property (nonatomic , copy)NSString *info;

@property (nonatomic , copy)NSString *mid;

@property (nonatomic , copy)NSString *cre_time;

@property (nonatomic , copy)NSString *income;

@property (nonatomic , copy)NSString *balance;

@property (nonatomic , copy)NSString *expend;



+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
