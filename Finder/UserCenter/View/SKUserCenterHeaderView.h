//
//  SKUserCenterHeaderView.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/3.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKUserCenterHeaderViewanswerClickDelegate <NSObject>

-(void)questionClick:(NSInteger)type;

@end

@interface SKUserCenterHeaderView : UITableViewHeaderFooterView

@property (weak ,nonatomic) id<SKUserCenterHeaderViewanswerClickDelegate> vDelegate;

- (void)setupUserInfoHeaderViewWithdic:(NSDictionary *)dict nickName:(NSString *)nickname imagePath:(NSString *)path  type:(NSInteger)type active:(NSInteger)active;

@end
