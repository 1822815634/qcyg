//
//  SKPersonMainTypeCell.h
//  Stockallocation
//
//  Created by SoWhat on 2018/11/14.
//  Copyright © 2018年 SoWhat. All rights reserved.
//
/**充值模块*/
#import <UIKit/UIKit.h>

@protocol SKPersonMainTypeCellDelegate <NSObject>

-(void)SKPersonMainTypeCellClick:(NSInteger)tag;

@end

@interface SKPersonMainTypeCell : UITableViewCell

@property (weak ,nonatomic) id<SKPersonMainTypeCellDelegate> vDelegate;

@end
