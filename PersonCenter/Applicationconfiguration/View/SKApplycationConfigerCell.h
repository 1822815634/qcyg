//
//  SKApplycationConfigerCell.h
//  Stockallocation
//
//  Created by hxisWater on 2019/1/2.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKApplycationConfigerCelldidClickViewDelegate <NSObject>

-(void)SKApplycationConfigerCellClick:(NSInteger)tag index:(NSIndexPath *)index;

@end

@class SKapplycationfiguratModel;

@interface SKApplycationConfigerCell : UITableViewCell

- (void)setupViewWithModel:(SKapplycationfiguratModel *)model index:(NSIndexPath *)index;

- (void)initCellWithModel:(SKapplycationfiguratModel *)model;

@property (weak ,nonatomic) id<SKApplycationConfigerCelldidClickViewDelegate> vDelegate;

@end
