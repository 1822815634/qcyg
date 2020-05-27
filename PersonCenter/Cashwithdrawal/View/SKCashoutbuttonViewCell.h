//
//  SKCashoutbuttonViewCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/29.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKCashouShowdidClickViewDelegate <NSObject>

-(void)senderDidClick;

@end

@interface SKCashoutbuttonViewCell : UITableViewCell

- (void)setbuttontile:(NSString *)title type:(NSInteger)type;

@property (weak ,nonatomic) id<SKCashouShowdidClickViewDelegate> vDelegate;

@end
