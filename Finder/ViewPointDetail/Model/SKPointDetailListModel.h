//
//  SKPointDetailListModel.h
//  Stockallocation
//
//  Created by wuyou on 2019/8/13.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface SKPointDetailListModelResponse :NSObject
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * bimgurl;
@property (nonatomic , copy) NSString              * brealname;
@property (nonatomic , copy) NSString              * cre_time;
@property (nonatomic , copy) NSString              * uid;

@end

@interface SKPointDetailListModel : SKBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , strong) NSArray<SKPointDetailListModelResponse *>              * data;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * page;

@end


NS_ASSUME_NONNULL_END
