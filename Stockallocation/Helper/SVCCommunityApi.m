//
//  SVCCommunityApi.m
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SVCCommunityApi.h"
#import "BKNetworkHelper.h"
@implementation SVCCommunityApi

#pragma mark --> 初始化网络请求对象
+ (BKNetworkHelper *)initNetHelper
{
    return [BKNetworkHelper shareInstance];
}

#pragma mark --> 获取轮播图
+(void)GetcarouselWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/index/carousel"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark -->获取首页头条数据
+ (void)GethotNewsWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/index/game"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取验证码
+ (void)GetAuthCodeWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"app/public/sendMsg"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
    
}

#pragma mark --> 获取银行卡信息
+(void)getBankInfoWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/bank/info"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 实名认证提交
+(void)commitRelaNicknameNSDictionary:(NSDictionary *)parameters
                         BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/accountmanage/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

+(void)getSmsCode:(NSDictionary *)parameters
     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
          andfail:(void (^)(NSError *error))fail path:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/accountmanage/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

+(void)smsCheck1:(NSDictionary *)parameters
    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
         andfail:(void (^)(NSError *error))fail path:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/accountmanage/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

+(void)up_tel:(NSDictionary *)parameters
 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
      andfail:(void (^)(NSError *error))fail path:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/accountmanage/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark 社区banner
+ (void)bannerWithDictionary:(NSDictionary *)parameters  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/index/get_index_img"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 问答列表/观点列表/个人中心
+(void)questionListWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"community/index/",path];
    if ([path isEqualToString:@"type"]) {
        url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"community/problem/lists"];
    }
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 问答列表详情
+(void)questionListDeatailWithNSDictionary:(NSDictionary *)parameters
                              BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                   andfail:(void (^)(NSError *error))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"community/index/wen_show"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}


#pragma mark --> 提现记录
+(void)withdrawWithNSDictionary:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"finance/withdraw/",path];
    
    if(![path isEqualToString:@"apply"]) {
        parameters = [self tokenParamster];
    }
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}


#pragma mark --> 交易记录
+(void)tradeHistoryWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"finance/deal/",path];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 优惠券列表
+(void)CouponListWithNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/Coupon/info"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 报名比赛
+(void)applyRaceWithNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail path:(NSString *)payh
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"home/tournament/",payh];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 关注-取消关注 观点详情
+(void)pointFocusNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"community/point/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 个人基本信息
+(void)userInfoWithNSDictionary:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/index/info"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 公告信息
+(void)AnnouncementinformationWithNSDictionary:(NSDictionary *)parameters
                                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                       andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"home/index/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        if([path isEqualToString:@"ranking"]){
            success(result,message,responseObject);
        }else{
            success(result,message,responseObject);
        }
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 商品兑换记录
+(void)recordHistoryWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"community/Trophy/record"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 商品列表
+(void)GoodsListWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"community/Trophy/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 追保详情
+(void)renewaldetailWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"stock/renewal/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 我的获奖
+(void)lastAwardWithNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/Tournament/my"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 操盘头部信息接口
+(void)simulateAnalogdiskWithNSDictionary:(NSDictionary *)parameters
                             BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                  andfail:(void (^)(NSError *error))fail{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"stock/simulate/index"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 关于部分
+(void)abouthelpNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"help/index/index"];
    [[self initNetHelper] POST:url Parameters:nil Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 股票交易信息
+(void)SimulateInfoNSDictionary:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"Stock/Simulate/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
    
        NSInteger result=[[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 大厅数据相关
+(void)TournamentWithNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"home/tournament/",path];
    if ([path isEqualToString:@"redemption"] || [path isEqualToString:@"home"]||[path isEqualToString:@"ranking"]) {

    }else{
    parameters = [self tokenParamster];
    }
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
           success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 续约追保
+(void)zhaiyueZhuiBaoNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"stock/futures/index"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
            success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

+(void)renewalWithNSDictionary:(NSDictionary *)parameters
                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                       andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"stock/renewal/",path];
    if ([path isEqualToString:@"renewal_add"]) {
    }else if ([path isEqualToString:@"add"]){
    }else{
         parameters = [self tokenParamster];
    }
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        if ([path isEqualToString:@"index"]) {
            success(result,message,responseObject);
        }else{
            success(result,message,responseObject[@"data"]);
        }
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取资产基本信息
+(void)getassetsWithNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"finance/assets/",path];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 签到
+(void)signInWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"community/Score/",path];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 添加银行卡
+(void)addBankCardWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/bankcard/add"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 解绑银行卡
+(void)moveBankCardWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/bank/move"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 提交提盈
+(void)commitTiyingWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/mention/apply"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 提盈记录
+(void)historyTiyingWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/mention/log"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取线下充值信息
+(void)getRechargePayWithNSDictionary:(NSDictionary *)parameters
                         BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"finance/Recharge/",path];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 提交线下充值
+(void)offLineRechargeWithNSDictionary:(NSDictionary *)parameters
                          BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                               andfail:(void (^)(NSError *error))fail path:(NSString *)path
{
    NSString *url;
    if ([path isEqualToString:@"ysb_charge"]) {
        url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/yspay/",path];
    }else if ([path isEqualToString:@"pay"]){
        url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"finance/Recharge/",path];
    }else{
        NSLog(@"提交验证没有处理,将返回错误数据");
        url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"finance/Recharge/",path];
    }
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 注册账号
+ (void)RegUserWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"User/Index/register"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
          NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
       fail(error);
    } type:@"1"];
}
#pragma mark --> 获取registertoken
+ (void)registerTokenWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/index/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

+ (void)loginCodeWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail path:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/index/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取用户昵称
+ (void)getUserNicknameNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/accountmanage/getusername"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取投顾信息
+(void)getadviserInfoNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"community/index/",path];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}
#pragma mark --> 设置用户昵称
+ (void)setUserNicknameNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/accountmanage/setusername"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}
#pragma mark --> 推广赚钱
+ (void)expandmoneyWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"user/accountmanage/",path];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        NSLog(@"%@ /n %@ /n %@ ",url,parameters,responseObject);
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 账户登录
+ (void)LoginWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void (^)(NSInteger, NSString *, NSDictionary *))success andfail:(void (^)(NSError *))fail
{
     NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/index/login"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        fail(error);
          NSLog(@"%@ /n %@ ",url,parameters);
    } type:@"1"];
}

#pragma mark --> 忘记密码，重新设置密码
+(void)passwordChangeWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"User/Index/password"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
       
        fail(error);
    } type:@"0"];
}

#pragma mark --> 点赞
+(void)giveZsumWithNSDictionary:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"community/point/like"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject[@"data"]);
    } Failure:^(NSError *error) {
        
        fail(error);
    } type:@"0"];
}

#pragma mark --> 获取股票信息
+(void)getStockMessageWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/mention/account"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}
+(void)XMgetBankListWithNSDictionary:(NSDictionary *)parameters
                          BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                               andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/bank/support_bank"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}
#pragma mark --> 获取省份列表
+(void)XMgetPrvinceListWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"Other/index/province"];
    [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {
        
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}


#pragma mark --> 获取城市列表
+(void)XMgetCityListWithNSDictionary:(NSDictionary *)parameters
                           BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"Other/index/city"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result=[[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 添加银行卡
+(void)XMgetAddBankCradWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"finance/bank/add"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result = [[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 上传头像
+(void)SetImageWithNSDictionary:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/index/setImg"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result = [[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 买入股票
+(void)BuyinWithNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail path:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"stock/simulate/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result = [[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取关于页面
+(void)AboutUSWithNSDictionary:(NSDictionary *)parameters
                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                       andfail:(void (^)(NSError *error))fail
{
    [[self initNetHelper] GET:[NSString stringWithFormat:@"%@%@",ServerPath,@"help/index/index"] Parameters:nil Success:^(id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"code"]integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
         fail(error);
    }];
}

#pragma mark --> 可用优惠券
+(void)futuresCouponWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail
{
     NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"stock/futures/Coupon"];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 获取用户余额
+(void)getBalanceWithNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail
{
     NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/index/balance"];
     [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {

     NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
     NSString *message=[responseObject objectForKey:@"msg"];
     success(result,message,responseObject);
     } Failure:^(NSError *error) {
     fail(error);
     } type:@"1"];
}

#pragma mark --> 获取认证支付信息
+(void)getRzPayInfoWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail{
        NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"user/rzpay/info"];
        [[self initNetHelper] POST:url Parameters:[self tokenParamster] Success:^(id responseObject) {

        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
        } Failure:^(NSError *error) {
        fail(error);
        } type:@"1"];
}

#pragma mark --> 提交天天策略或者初级牛人
+(void)CommitfuturesWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail path:(NSString *)path{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",ServerUrl,@"stock/futures/",path];
    [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
        NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
        NSString *message=[responseObject objectForKey:@"msg"];
        success(result,message,responseObject);
    } Failure:^(NSError *error) {
        fail(error);
    } type:@"1"];
}

#pragma mark --> 开关接口
+ (void)hudeIsOpenWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success andfail:(void (^)(NSError *error))fail{
       NSString *url = [NSString stringWithFormat:@"%@%@",ServerUrl,@"home/index/is_open"];
       [[self initNetHelper] POST:url Parameters:parameters Success:^(id responseObject) {
       NSInteger result= [[responseObject objectForKey:@"code"] integerValue];
       NSString *message=[responseObject objectForKey:@"msg"];
       success(result,message,responseObject);
       } Failure:^(NSError *error) {
       fail(error);
       } type:@"1"];
}
+ (NSDictionary *)tokenParamster
{
    NSString *token = [SKUserInfoModel userToken];
    if(token.length < 5){
       token =  @"";
    }
    return @{@"token":token,@"timeformat":@"Y-m-d H:i:s"};
}

@end
