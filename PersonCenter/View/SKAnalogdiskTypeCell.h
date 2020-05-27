//
//  SKAnalogdiskTypeCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/16.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKAnalogdiskTypeCellDelegate <NSObject>

-(void)SKAnalogdiskTypeCellTypeViewClick:(NSInteger)tag;

@end

@interface SKAnalogdiskTypeCell : UITableViewCell

- (void)setupViewwithTag:(NSInteger)tag titleArr:(NSArray *)arr;

@property (weak ,nonatomic) id<SKAnalogdiskTypeCellDelegate> vDelegate;

@end
