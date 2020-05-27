//
//  SKoutLoginCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/19.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKoutLogoutCellClickViewDelegate <NSObject>

-(void)SKoutLogoutCellClick;

@end

@interface SKoutLoginCell : UITableViewCell

@property (weak ,nonatomic) id<SKoutLogoutCellClickViewDelegate> vDelegate;

@end
