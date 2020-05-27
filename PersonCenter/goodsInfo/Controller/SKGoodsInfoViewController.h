//
//  SKGoodsInfoViewController.h
//  Stockallocation
//
//  Created by hxisWater on 2018/12/26.
//  Copyright © 2018 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKGoodsInfoViewControllerExchangeSuccessDelegate <NSObject>

-(void)changeSuccessful;

@end
@interface SKGoodsInfoViewController : SKBaseViewController

//定义枚举类型
typedef enum {
    Integralfictitions=0, //虚拟商品
    Integralreality //真实商品
} Integral_Type;

@property (nonatomic,assign) NSInteger InActionType;

@property (nonatomic , copy)NSString *uid;

@property (weak ,nonatomic) id<SKGoodsInfoViewControllerExchangeSuccessDelegate> vDelegate;

@end
