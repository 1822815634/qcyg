//
//  SKAnnouncementmessageModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/22.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKAnnouncementmessageModel : SKBaseModel

@property (nonatomic , copy)NSString *but_id;

@property (nonatomic , copy)NSString  *title;

@property (nonatomic , copy)NSString *content;

@property (nonatomic , copy)NSString *cre_time;


+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
