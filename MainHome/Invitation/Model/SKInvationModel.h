//
//  SKInvationModel.h
//  Stockallocation
//
//  Created by SoWhat on 2019/1/13.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKInvationModel : SKBaseModel

@property (nonatomic , assign)CGFloat amount;

@property (nonatomic , copy)NSString * cre_time;

@property (nonatomic , assign)NSInteger dates;

@property (nonatomic , copy)NSString  *tel;

@property (nonatomic , copy)NSString *money;

@property (nonatomic , copy)NSString *nickname;

@property (nonatomic , copy)NSString *realname;

@property (nonatomic , assign)NSInteger state;

@property (nonatomic ,copy)NSString *balance;




+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
