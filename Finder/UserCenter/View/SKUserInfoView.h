//
//  SKUserInfoView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKUserInfoViewanwerClickViewDelegate <NSObject>

-(void)answerClick:(NSInteger)tag;

@end

@interface SKUserInfoView : UIView

// xib 加载自定义的view
+ (SKUserInfoView *)instanceSKUserInfoView;

@property (weak ,nonatomic) id<SKUserInfoViewanwerClickViewDelegate> vDelegate;

- (void)setUserInfoView:(NSDictionary *)dict;

- (void)setNickName:(NSString *)nickName withType:(NSInteger)type active:(NSInteger)active;

@end
