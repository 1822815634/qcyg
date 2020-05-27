//
//  SKRelaNamecertificationViewController.h
//  Stockallocation
//
//  Created by SoWhat on 2018/11/23.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBaseViewController.h"

@protocol SettingSuccessfulDelegate <NSObject>

-(void)setSuccessful;

@end

@interface SKRelaNamecertificationViewController : SKBaseViewController

//定义枚举类型
typedef NS_ENUM(NSInteger,Rela_Type) {
    RelaName = 0, //设置实名认证
    Relapassword,//修改支付密码
    loginPwd
};

@property (nonatomic,assign) NSInteger name_Type;

@property (weak ,nonatomic) id<SettingSuccessfulDelegate> Vdelegate;

@end
