//
//  SKviewPointModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKviewPointModel : SKBaseModel

@property (nonatomic , assign)NSInteger guandian_id;

@property (nonatomic , assign)NSInteger uid;

@property (nonatomic , assign)NSInteger state;

@property (nonatomic , assign)NSInteger r_sum;

@property (nonatomic , assign)NSInteger w_sum;

@property (nonatomic , assign)NSInteger z_sum;

@property (nonatomic , assign)NSInteger active; //1已经关注 0未关注

@property (nonatomic , copy)NSString  *title;

@property (nonatomic , copy)NSString *content;

@property (nonatomic , copy)NSString *create_time;

@property (nonatomic , copy)NSString *author;

@property (nonatomic , copy)NSString *imgurl;

@property (nonatomic , assign)CGFloat contentHeight;

@property (nonatomic , copy)NSString *att_id;

@property (nonatomic , copy)NSString *fans_num;

@property (nonatomic , copy)NSString *nickname;

@property (nonatomic , copy)NSString *total;

@property (nonatomic , copy)NSString *realname;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
