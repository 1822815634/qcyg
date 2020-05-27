//
//  SKSettingNickNameViewController.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/23.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import "SKBaseViewController.h"

@protocol SKSettingNickNameSuccessfulDelegate <NSObject>

-(void)setNicknameSuccessful:(NSString *)nickName;

@end


@interface SKSettingNickNameViewController : SKBaseViewController

@property (weak ,nonatomic) id<SKSettingNickNameSuccessfulDelegate> vDelegate;

@end
