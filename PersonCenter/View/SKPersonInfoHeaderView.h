//
//  SKPersonInfoHeaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/13.
//  Copyright © 2018年 SoWhat. All rights reserved.
//
/** 我的 头部视图*/
#import <UIKit/UIKit.h>

@protocol SKPersonInfoHeaderViewSettingClickViewDelegate <NSObject>

-(void)SKPersonInfoHeaderViewSettingClick;

@end

@interface SKPersonInfoHeaderView : UITableViewHeaderFooterView

@property (weak ,nonatomic) id<SKPersonInfoHeaderViewSettingClickViewDelegate> vDelegate;

- (void)setupUserInfoHeaderView:(NSDictionary *)dict;


@end
