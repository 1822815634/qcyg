//
//  SKQuestionDetailModel.h
//  Stockallocation
//
//  Created by wuyou on 2019/8/7.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKQuestionDetailModelResponse :NSObject
@property (nonatomic , copy) NSString              * au_img;
@property (nonatomic , copy) NSString              * au_uid;
@property (nonatomic , copy) NSString              * au_nickname;
@property (nonatomic , copy) NSString              * au_content;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * cre_time;
@property (nonatomic , copy) NSString              * au_cre_time;
@property (nonatomic , copy) NSString              *is_gz;

@end

@interface SKQuestionDetailModel : SKBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , strong) SKQuestionDetailModelResponse              * data;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * page;

@end



NS_ASSUME_NONNULL_END
