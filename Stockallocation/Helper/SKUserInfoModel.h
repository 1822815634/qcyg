//
//  SKUserInfoModel.h
//  Stockallocation
//
//  Created by hxisWater on 2019/3/25.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKUserInfoModel : NSObject

/** 用户token  */
@property(nonatomic,copy)NSString *token;

/** 用户token  */
@property(nonatomic,copy)NSString *uid;

// 用户是否同意协议
@property (nonatomic , copy)NSString *isAgreet;


+ (instancetype)modelWithDict:(NSDictionary *)dict;
/**
 保存用户信息
 */
- (void)saveUserModel;
/**
 获取当前用户信息对象
 */
+ (instancetype)userModel;
/**
 清除本地用户信息
 */
+ (void)deleteModel;

#pragma mark -->  获取用户token
+ (NSString *)userToken;

#pragma mark --> 获取用户uid
+ (NSString *)userUid;


+ (NSString *)userAgreetRisk;


@end
