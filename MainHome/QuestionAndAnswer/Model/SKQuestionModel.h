//
//  SKQuestionModel.h
//  Stockallocation
//
//  Created by SoWhat on 2019/1/21.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

@interface SKQuestionModel : SKBaseModel

@property (nonatomic , copy)NSString *tid;
@property (nonatomic , copy)NSString *question_id;
@property (nonatomic , copy)NSString *imgurl;
@property (nonatomic , copy)NSString *nickname;
@property (nonatomic , copy)NSString *content;
@property (nonatomic , copy)NSString *h_type;
@property (nonatomic , copy)NSString *uid;
@property (nonatomic , copy)NSString *hd_img;
@property (nonatomic , copy)NSString *hd_nickname;
@property (nonatomic , copy)NSString *hdcontent;
@property (nonatomic , copy)NSString *hdcre_time;
@property (nonatomic , copy)NSString *cre_time;
@property (nonatomic , copy)NSString *hd_status;

+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
