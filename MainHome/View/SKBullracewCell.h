//
//  SKBullracewCell.h
//  Stockallocation
//
//  Created by hxisWater on 2018/11/20.
//  Copyright © 2018年 SoWhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKStockModel;

@protocol SKBullracewCellViewDelegate <NSObject>

-(void)SKBullracewCellTypeViewClick:(NSInteger)tag index:(NSIndexPath *)index;

@end

@interface SKBullracewCell : UITableViewCell


@property (weak ,nonatomic) id<SKBullracewCellViewDelegate> vDelegate;

- (void)setupBullraceCellWithmodel:(SKStockModel *)model index:(NSIndexPath *)index;

@end
