//
//  SKSettingViewController.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//
/**设置页面*/
#import <UIKit/UIKit.h>

@protocol SKSettingViewControllerReflashDelegate <NSObject>

-(void)updateHeaderImagell;

@end

@interface SKSettingViewController : SKBaseViewController

@property (nonatomic , copy)NSString *headerImagellPath;

@property (weak ,nonatomic) id<SKSettingViewControllerReflashDelegate> vDelegate;

@end
