//
//  SKUserInfoModel.m
//  Stockallocation
//
//  Created by hxisWater on 2019/3/25.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "SKUserInfoModel.h"
#import <MJExtension.h>
#define ArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userModel.archive"]

@implementation SKUserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    SKUserInfoModel *model = [SKUserInfoModel mj_objectWithKeyValues:dict];
    return model;
}
MJCodingImplementation
- (void)saveUserModel
{
    [SKUserInfoModel deleteModel];
    [NSKeyedArchiver archiveRootObject:self toFile:ArchivePath];
}

+ (instancetype)userModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:ArchivePath];
}

+ (NSString *)userToken
{
   SKUserInfoModel *model = [SKUserInfoModel userModel];
    return model.token;
}

+ (NSString *)userUid
{
    SKUserInfoModel *model = [SKUserInfoModel userModel];
    return model.uid;
}

+ (NSString *)userAgreetRisk
{
    SKUserInfoModel *model = [SKUserInfoModel userModel];
    return model.isAgreet;
}


+ (void)deleteModel
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:ArchivePath]) {
        [defaultManager removeItemAtPath:ArchivePath error:nil];
    }
}

@end
