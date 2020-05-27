//
//  SVCCommunityApi.h
//  SmartValleyCloudSeeding
//
//  Created by hxisWater on 2018/6/11.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVCCommunityApi : NSObject
typedef void (^Failure)(NSError *failure);

#pragma mark --> 首页轮播图
+(void)GetcarouselWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 首页头条数据
+(void)GethotNewsWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取验证码
+(void)GetAuthCodeWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 注册账号
+(void)RegUserWithNSDictionary:(NSDictionary *)parameters
                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                       andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取registerToken
+(void)registerTokenWithNSDictionary:(NSDictionary *)parameters
                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail path:(NSString *)path;
#pragma mark --> 获取登录验证码
+(void)loginCodeWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 获取用户昵称
+(void)getUserNicknameNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取投顾信息
+(void)getadviserInfoNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 实名认证提交
+(void)commitRelaNicknameNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark 发送验证码
+(void)getSmsCode:(NSDictionary *)parameters
                         BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark 校验验证码
+(void)smsCheck1:(NSDictionary *)parameters
     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
          andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark 修改手机号
+(void)up_tel:(NSDictionary *)parameters
    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
         andfail:(void (^)(NSError *error))fail path:(NSString *)path;




#pragma mark --> 续约追保
+(void)zhaiyueZhuiBaoNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 设置用户昵称
+(void)setUserNicknameNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;
#pragma mark --> 推广赚钱
+(void)expandmoneyWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 商品兑换记录
+(void)recordHistoryWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail;

#pragma mark --> 商品列表
+(void)GoodsListWithNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail  path:(NSString *)path;

#pragma mark 社区banner
+ (void)bannerWithDictionary:(NSDictionary *)parameters  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail;

#pragma mark --> 问答列表
+(void)questionListWithNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 问答列表详情
+(void)questionListDeatailWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail;

#pragma mark --> 优惠券列表
+(void)CouponListWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取资产基本信息
+(void)getassetsWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 签到
+(void)signInWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 追保详情
+(void)renewaldetailWithNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 我的获奖
+(void)lastAwardWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail;

#pragma mark --> 操盘头部信息接口
+(void)simulateAnalogdiskWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail;

#pragma mark --> 个人基本信息
+(void)userInfoWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;


#pragma mark --> 报名比赛
+(void)applyRaceWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail path:(NSString *)payh;

#pragma mark --> 关于部分
+(void)abouthelpNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                         andfail:(void (^)(NSError *error))fail;

#pragma mark --> 股票交易信息
+(void)SimulateInfoNSDictionary:(NSDictionary *)parameters
                    BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 关注-取消关注
+(void)pointFocusNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                      andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 公告信息
+(void)AnnouncementinformationWithNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 大厅数据相关
+(void)TournamentWithNSDictionary:(NSDictionary *)parameters
                 BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 续约首页数据
+(void)renewalWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                       andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 获取银行卡信息
+(void)getBankInfoWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;
#pragma mark --> 添加银行卡
+(void)addBankCardWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;
#pragma mark --> 解绑银行卡
+(void)moveBankCardWithNSDictionary:(NSDictionary *)parameters
                      BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                           andfail:(void (^)(NSError *error))fail;

#pragma mark --> 交易记录
+(void)tradeHistoryWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 提现记录
+(void)withdrawWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                        andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 提交提盈
+(void)commitTiyingWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail;

#pragma mark --> 提盈记录
+(void)historyTiyingWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                            andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取线下充值信息
+(void)getRechargePayWithNSDictionary:(NSDictionary *)parameters
                       BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 提交线下充值
+(void)offLineRechargeWithNSDictionary:(NSDictionary *)parameters
                         BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail  path:(NSString *)path;

#pragma mark --> 账户登录
+(void)LoginWithNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail;

#pragma mark --> 忘记密码，修改密码
+(void)passwordChangeWithNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail;

#pragma mark --> 点赞
+(void)giveZsumWithNSDictionary:(NSDictionary *)parameters
                         BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                              andfail:(void (^)(NSError *error))fail;


#pragma mark --> 获取股票信息
+(void)getStockMessageWithNSDictionary:(NSDictionary *)parameters
                          BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                               andfail:(void (^)(NSError *error))fail;
#pragma mark --> 获取银行列表
+(void)XMgetBankListWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;
#pragma mark --> 获取省份列表
+(void)XMgetPrvinceListWithNSDictionary:(NSDictionary *)parameters
                           BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                andfail:(void (^)(NSError *error))fail;
#pragma mark --> 获取城市列表
+(void)XMgetCityListWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;
#pragma mark --> 添加银行卡
+(void)XMgetAddBankCradWithNSDictionary:(NSDictionary *)parameters
                           BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                andfail:(void (^)(NSError *error))fail;

#pragma mark --> 上传头像
+(void)SetImageWithNSDictionary:(NSDictionary *)parameters
                           BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                                andfail:(void (^)(NSError *error))fail;

#pragma mark --> 买入股票
+(void)BuyinWithNSDictionary:(NSDictionary *)parameters
                   BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail path:(NSString *)path;

#pragma mark --> 获取关于页面
+(void)AboutUSWithNSDictionary:(NSDictionary *)parameters
                BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                     andfail:(void (^)(NSError *error))fail;

#pragma mark --> 可用优惠券
+(void)futuresCouponWithNSDictionary:(NSDictionary *)parameters
                  BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                       andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取用户余额
+(void)getBalanceWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail;

#pragma mark --> 获取认证支付信息
+(void)getRzPayInfoWithNSDictionary:(NSDictionary *)parameters
                     BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                          andfail:(void (^)(NSError *error))fail;


#pragma mark --> 提交天天策略或者初级牛人
+(void)CommitfuturesWithNSDictionary:(NSDictionary *)parameters
                        BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success
                             andfail:(void (^)(NSError *error))fail path:(NSString *)path;
#pragma mark --> 开关接口
+ (void)hudeIsOpenWithNSDictionary:(NSDictionary *)parameters BlockSuccess:(void(^)(NSInteger, NSString *,NSDictionary *JSON))success andfail:(void (^)(NSError *error))fail;

@end
;
