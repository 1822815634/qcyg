//
//  SKviewPointInfoModel.h
//  Stockallocation
//
//  Created by SoWhat on 2019/4/28.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKviewPointInfoModel : SKBaseModel

@property (nonatomic , copy)NSString *bimgurl;

@property (nonatomic , copy)NSString *brealname;

@property (nonatomic , copy)NSString *content;

@property (nonatomic , copy)NSString *cre_time;

@property (nonatomic , copy)NSString *uid;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
