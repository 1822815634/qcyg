//
//  SKStockModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/14.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKStockModel : SKBaseModel

/*
 start_time     string     最新一期 开始时间
 end_time     string     结束时间
 title     string     赛期名称
 game_id     string     大赛id
 renshu     string     人数
 cuid     int     参赛用户id 0:未参加
 status     int     大赛状态 0：进行中 1：等待开始 2：已结束
 */
@property (nonatomic , copy)NSString *start_time;

@property (nonatomic , assign)NSInteger count;

@property (nonatomic , copy)NSString *end_time;

@property (nonatomic , assign)NSInteger cuid;

@property (nonatomic , copy)NSString *game_id;

@property (nonatomic , copy)NSString *renshu;

@property (nonatomic , copy)NSString *title;

@property (nonatomic , assign)NSInteger status;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
