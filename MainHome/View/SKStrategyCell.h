//
//  SKStrategyCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/12.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKStrategyCellDelegate <NSObject>

-(void)SKStrategyCellJoinClickDelegateindex:(NSInteger)tag;

@end

@interface SKStrategyCell : UITableViewCell

@property (weak ,nonatomic) id<SKStrategyCellDelegate> vDelegate;

- (void)initTypeLab:(NSString *)type index:(NSInteger)tag;

@end
