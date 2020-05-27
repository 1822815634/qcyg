//
//  SKPointDetailModel.h
//  Stockallocation
//
//  Created by wuyou on 2019/8/12.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface SKPointDetailModelResponse :NSObject
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * active;
@property (nonatomic , copy) NSString              * guandian_id;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * r_sum;
@property (nonatomic , copy) NSString              * u_img;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * w_sum;
@property (nonatomic , copy) NSString              * is_gz;
@property (nonatomic , copy) NSString              *is_zan;

@end

@interface SKPointDetailModel : SKBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , strong) SKPointDetailModelResponse              * data;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * page;

@end


NS_ASSUME_NONNULL_END
